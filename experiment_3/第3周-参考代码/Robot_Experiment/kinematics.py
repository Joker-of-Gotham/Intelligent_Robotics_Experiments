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
    
    # --- 打印输入参数 ---
    print("\n==================[ Kinematics Analysis Start ]==================")
    print(f"[Input] Target Coordinates: x={x:.2f}, y={y:.2f}, z={z:.2f}, Alpha={Alpha:.2f}")

    #放大10倍
    x = x*10
    y = y*10
    z = z*10
    
    if(x == 0 and y != 0) :
        theta6 = 0.0
    elif(x > 0 and y == 0):
        theta6 = 90
    elif(x < 0 and y == 0):
        theta6 = -90
    else :
        theta6 = atan(x/y)*180.0/pi #计算云台旋转角度
    
    print(f"[Calc] Base Servo Angle (theta6): {theta6:.2f} degrees")

    # ------------------- 代码补充部分 (带打印) -------------------
    
    # 将Alpha角度转为弧度
    a = Alpha * pi / 180.0
    
    # I. 已知x,y, 求解坐标的斜边 q
    q = sqrt(x*x + y*y)
    
    # II. 在机械臂投影到斜边平面后，计算 y1+y2 和 z1+z2
    y_new = q - l3 * cos(a)
    z_new = z - l0 - l3 * sin(a)
    print(f"[Step 1: Projection] 3D to 2D plane: q={q:.2f}, y_new={y_new:.2f}, z_new={z_new:.2f}")

    # 判断是否超出范围
    if(z_new < -100) : 
        print("[Error] Kinematics failed: Target is too low (z_new < -100).")
        print("===================[ Kinematics Analysis End ]===================")
        return 1;
    dist_to_target = sqrt(y_new*y_new + z_new*z_new)
    max_reach = l1 + l2
    if(dist_to_target > max_reach) :
        print(f"[Error] Kinematics failed: Target is unreachable. Distance ({dist_to_target:.2f}) > Max Reach ({max_reach:.2f}).")
        print("===================[ Kinematics Analysis End ]===================")
        return 2
    
    print(f"[Check] Reachability: OK. Distance ({dist_to_target:.2f}) <= Max Reach ({max_reach:.2f}).")

    # III. 计算l2末端与0点连线的水平夹角c和l1夹角b
    c = acos(y_new / dist_to_target)
    b_param = (y_new*y_new + z_new*z_new + l1*l1 - l2*l2) / (2 * l1 * dist_to_target)
    
    if b_param > 1.0: b_param = 1.0
    elif b_param < -1.0: b_param = -1.0
    
    b = acos(b_param)
    print(f"[Step 2: Triangle Solve] Intermediate angles (radians): c_rad={c:.2f}, b_rad={b:.2f} (from b_param={b_param:.2f})")
    
    if (z_new < 0) : 
        zf_flag = -1
    else :
        zf_flag = 1
    
    # IV. 计算1号舵机的弧度
    theta1_rad = c * zf_flag + b
    theta1 = theta1_rad * 180.0 / pi; # 转化为角度 
    print(f"[Step 3: Joint 1 Angle] theta1 = {theta1:.2f} degrees")
    if(theta1 > 180.0 or theta1 < 0.0) :
        print(f"[Error] Kinematics failed: Joint 1 angle ({theta1:.2f}) out of range [0, 180].")
        print("===================[ Kinematics Analysis End ]===================")
        return 4
    
    # V. 计算2号舵机的弧度，再转化为角度
    theta2_param = (l1*l1 + l2*l2 - (y_new*y_new + z_new*z_new)) / (2 * l1 * l2)
    if theta2_param > 1.0: theta2_param = 1.0
    elif theta2_param < -1.0: theta2_param = -1.0
    
    theta2_rad = acos(theta2_param)
    theta2 = 180 - theta2_rad * 180 / pi
    theta2 = -(theta2 - 90 + 90)
    print(f"[Step 4: Joint 2 Angle] theta2 = {theta2:.2f} degrees (from param={theta2_param:.2f})")

    if (theta2 > 135.0 or theta2 < -135.0) :    #判断是否越界
        print(f"[Error] Kinematics failed: Joint 2 angle ({theta2:.2f}) out of range [-135, 135].")
        print("===================[ Kinematics Analysis End ]===================")
        return 6
    
    # VI. 计算3号舵机的弧度，再转化为角度
    theta3 = a * 180.0 / pi - theta1 - theta2
    print(f"[Step 5: Joint 3 Angle] theta3 = {theta3:.2f} degrees")
    if(theta3 > 90.0 or theta3 < -90.0) :
        print(f"[Error] Kinematics failed: Joint 3 angle ({theta3:.2f}) out of range [-90, 90].")
        print("===================[ Kinematics Analysis End ]===================")
        return 7
    
    # ------------------- 赋值与转换 -------------------
    
    servo_angle[0] = theta6
    servo_angle[1] = theta1-90 # 物理安装偏差校正
    servo_angle[2] = theta2
    servo_angle[3] = theta3    
    print(f"[Result] Final Servo Angles (for PWM calc): {servo_angle}")

    servo_pwm[0] = (int)(1500-2000.0 * servo_angle[0] / 270.0);
    servo_pwm[1] = (int)(1500+2000.0 * servo_angle[1] / 270.0);
    servo_pwm[2] = (int)(1500+2000.0 * servo_angle[2] / 270.0);
    servo_pwm[3] = (int)(1500+2000.0 * servo_angle[3] / 270.0);
    print(f"[Output] Final PWM values: {servo_pwm}")
    print("===================[ Kinematics Analysis Success ]===================")
    
    return 0;

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