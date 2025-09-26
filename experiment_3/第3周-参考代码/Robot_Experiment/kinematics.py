from math import *
import sys
sys.path.append('/home/pi/Desktop/Robot_Experiment/Lib/')
import time
import UartServer
import Beep

pi = 3.1415926


servo_angle = [0,0,0,0]#记录角度
servo_pwm = [0,0,0,0]#记录pwm

'''

设置四个关节的长度
单位0.1mm
l0  底盘到第二个舵机中心轴的距离
l1  第二个舵机到第三 个舵机的距离
l2  第三个舵机到第四 个舵机的距离
l3  第四个舵机到机械臂(闭合后)最高点的距离

'''
def setup_kinematics(L0, L1, L2, L3) :
    global l0, l1 ,l2 ,l3
    #放大10倍
    l0 = L0*10
    l1 = L1*10
    l2 = L2*10
    l3 = L3*10

'''
    x,y 为映射到平面的坐标
    z为距离地面的距离
    Alpha 为爪子和平面的夹角 -25~-65范围比较好
'''
#x,y,z为爪子闭合时的末端点的坐标，alpha为爪子与水平面的角度
def kinematics_analysis(x, y, z, Alpha):
    global pi,l0, l1 ,l2 ,l3,servo_angle,servo_pwm
    
    print("\n==================[ Kinematics Analysis Start ]==================")
    print(f"[Input] Target Coordinates: x={x:.2f}, y={y:.2f}, z={z:.2f}, Alpha={Alpha:.2f}")

    # 放大10倍以匹配内部单位
    x, y, z = x*10, y*10, z*10
    
    # --- 1. 计算底盘旋转角 theta6 ---
    if x == 0:
        theta6 = 0.0
    else:
        theta6 = atan2(x,y)*180.0/pi
    
    print(f"[Calc] Base Servo Angle (theta6): {theta6:.2f} degrees")

    # --- 2. 坐标降维，从3D空间投影到2D平面 ---
    a = Alpha * pi / 180.0
    q = sqrt(x*x + y*y)
    y_new = q - l3 * cos(a)
    z_new = z - l0 - l3 * sin(a)
    print(f"[Step 1: Projection] 3D to 2D plane: q={q:.2f}, y_new={y_new:.2f}, z_new={z_new:.2f}")

    # --- 3. 可达性判断 ---
    dist_to_target = sqrt(y_new*y_new + z_new*z_new)
    max_reach = l1 + l2
    if dist_to_target > max_reach * 1.001: # 乘以1.001以容忍浮点误差
        print(f"[Error] Kinematics failed: Target is unreachable. Distance ({dist_to_target:.2f}) > Max Reach ({max_reach:.2f}).")
        return 2 # 返回错误码
    
    # --- 4. 使用余弦定理求解各关节角度 ---
    # 解算 theta1 (肩膀关节)
    cos_b_param = (dist_to_target**2 + l1**2 - l2**2) / (2 * dist_to_target * l1)
    if cos_b_param > 1.0: cos_b_param = 1.0
    elif cos_b_param < -1.0: cos_b_param = -1.0
    b_rad = acos(cos_b_param)
    c_rad = atan2(z_new, y_new)
    theta1 = (c_rad + b_rad) * 180.0 / pi
    
    # 解算 theta2 (手肘关节)
    cos_theta2_param = (l1**2 + l2**2 - dist_to_target**2) / (2 * l1 * l2)
    if cos_theta2_param > 1.0: cos_theta2_param = 1.0
    elif cos_theta2_param < -1.0: cos_theta2_param = -1.0
    theta2 = (acos(cos_theta2_param) * 180.0 / pi) - 180.0

    # 解算 theta3 (手腕关节)
    theta3 = Alpha - theta1 - theta2
    
    print(f"[Step 2: Joint Angles] theta1={theta1:.2f}, theta2={theta2:.2f}, theta3={theta3:.2f}")

    # --- 5. 角度到PWM值的转换 (核心修正区域) ---
    servo_angle[0] = theta6
    servo_angle[1] = theta1 - 90 # 物理安装偏差校正
    servo_angle[2] = theta2
    servo_angle[3] = theta3    
    
    # ID 000 (Base): 角度增加 -> PWM减小
    servo_pwm[0] = int(1500 - 2000.0 * servo_angle[0] / 270.0)
    # ID 001 (Shoulder): 角度增加 -> PWM增加
    servo_pwm[1] = int(1500 + 2000.0 * servo_angle[1] / 270.0)
    # ID 002 (Elbow): <--- 关键修正点! 角度增加(更弯曲) -> PWM减小
    servo_pwm[2] = int(1500 - 2000.0 * servo_angle[2] / 270.0)
    # ID 003 (Wrist): 角度增加 -> PWM增加
    servo_pwm[3] = int(1500 + 2000.0 * servo_angle[3] / 270.0)

    print(f"[Corrected Output] Final PWM values: {servo_pwm}")
    print("===================[ Kinematics Analysis Success ]===================")
    
    return 0 # 返回成功码

#此函数可移植到要执行的主程序里面去
def kinematics_move(x,y,z,mytime): 
    global servo_pwm
    alpha_list = []
    if(y < 0):
        return 0;
    #寻找3号舵机的最佳角度
    flag = 0;
    best_alpha = 0
    for i in range(-25,-65,-1) :
        if kinematics_analysis(x,y,z,i):
            alpha_list.append(i)
    if len(alpha_list) > 0:
        if y > 2150:
            best_alpha = max(alpha_list)
        else:
            best_alpha = min(alpha_list)
        flag = 1
        
    #用3号舵机与水平最大的夹角作为最佳值
    if(flag) :
        kinematics_analysis(x,y,z,best_alpha);
        testStr = '{'
        for j in range(0,4) :
            #set_servo(j, servo_pwm[j], time);
            #print(servo_pwm[j])
            testStr += "#%03dP%04dT%04d!" % (j,servo_pwm[j],mytime)
        testStr += '}'
        print(testStr)
        myUart.uart_send_str(testStr)
        return 1
    
    return 0