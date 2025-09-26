#导入模块
import sys
sys.path.append('/home/pi/Desktop/Robot_Experiment/Lib/')
import cv2   #导入库
import Camera
import numpy as np
import time
import threading
from math import *

import UartServer as myUart
import Beep as myBeep
import kinematics as kms

color_dists = {
             'red':   {'Lower': np.array([0, 43, 35]), 'Upper': np.array([10, 255, 255])},
             'green': {'Lower': np.array([35, 43, 35]), 'Upper': np.array([90, 255, 255])},
             'blue':  {'Lower': np.array([100, 43, 46]), 'Upper': np.array([124, 255, 255])},
             }

width = 320
hight = 240

Running = True
clamp_step = 0
count = 0

#图像处理参数列表
index = -1
kms_x = 0
kms_y = 0
axis_x_lst = [0,0,0]
axis_y_lst = [0,0,0]
axis_x_cur = [0,0,0]
axis_y_cur = [0,0,0]
color_count = [0,0,0]

def reset():
    global count
    count = 0

def clamp_wood():
    global clamp_step,index,kms_x,kms_y,Running,clamp_flag,count,servo_yuntai,servo_zhuazi
    while 1:
        eEvent.wait() # 等待主线程信号
        
        # --- 步骤 1: 张开爪子并对准目标 ---
        if clamp_step == 1:
            print(f"\n--- [Step 1] Action: Open claw and aim at target. ---")
            Str = "#000P{0:0>4d}T{0:0>4d}!#004P{1:0>4d}T{2:0>4d}!#005P1200T{2:0>4d}!".format(servo_yuntai,servo_zhuazi, 1000)
            print(f"[UART Send] Command: {Str}")
            myUart.uart_send_str(Str)
            print("[Wait] Waiting for 2 seconds...")
            time.sleep(2)
            clamp_step = 2 

        # --- 步骤 2: 机械臂移动到目标上方 ---
        elif clamp_step == 2:
            print(f"--- [Step 2] Action: Move arm to target location ({kms_x-10:.2f}, {kms_y+10:.2f}, 15). ---")
            kinematics_move(kms_x-10,kms_y+10,15,2000)  # 此函数内部已有打印
            print("[Wait] Waiting for 2 seconds...")
            time.sleep(2)
            clamp_step = 3

        # --- 步骤 3: 闭合爪子抓取 ---
        elif clamp_step == 3:
            print("--- [Step 3] Action: Close claw to grab the object. ---")
            command = "#005P1900T1000!"
            print(f"[UART Send] Command: {command}")
            myUart.uart_send_str(command)
            print("[Wait] Waiting for 2 seconds...")
            time.sleep(2)
            clamp_step = 4     

        # --- 步骤 4: 抬起机械臂 ---
        elif clamp_step == 4:
            print("--- [Step 4] Action: Lift the arm. ---")
            lift_str = ("#000P1500T2500!"
                        "#001P2100T2000!"
                        "#002P2300T2000!"
                        "#003P1000T2000!"
                        "#004P1500T2000!"
                        "#005P1900T2000!")
            print(f"[UART Send] Command: {lift_str}")
            myUart.uart_send_str(lift_str)
            print("[Wait] Waiting for 3 seconds...")
            time.sleep(3)           
            clamp_step = 5

        # --- 步骤 5: 旋转机械臂到码垛区 ---
        elif clamp_step == 5:
            print("--- [Step 5] Action: Rotate arm to stacking area. ---")
            command = '#000P{:0>4d}T1000!'.format(int(1500-2000.0 * -90/ 270.0))
            print(f"[UART Send] Command: {command}")
            myUart.uart_send_str(command)     
            print("[Wait] Waiting for 1 second...")
            time.sleep(1)
            clamp_step = 6           
            
        # --- 步骤 6: 移动到码垛位置 ---
        elif clamp_step == 6:
            target_x = -200 + count * 3
            target_y = 50
            target_z = 20 + count * 30
            print(f"--- [Step 6] Action: Move to stacking position {count+1} ({target_x}, {target_y}, {target_z}). ---")
            kinematics_move(target_x, target_y, target_z, 2000)
            print("[Wait] Waiting for 3 seconds...")
            time.sleep(3)
            clamp_step = 7

        # --- 步骤 7: 张开爪子放置 ---
        elif clamp_step == 7:
            print("--- [Step 7] Action: Open claw to place the object. ---")
            command = "#005P1200T1000!"
            print(f"[UART Send] Command: {command}")
            myUart.uart_send_str(command)
            print("[Wait] Waiting for 1 second...")
            time.sleep(1)
            clamp_step = 8

        # --- 步骤 8: 抬起机械臂 ---
        elif clamp_step == 8:
            print("--- [Step 8] Action: Lift the arm after placement. ---")
            lift_str_2 = ("#001P2100T1500!"
                          "#002P2300T1500!"
                          "#003P1000T1500!"
                          "#004P1500T1500!")
            print(f"[UART Send] Command: {lift_str_2}")
            myUart.uart_send_str(lift_str_2)
            print("[Wait] Waiting for 2 seconds...")
            time.sleep(2)
            clamp_step = 9           
        
        # --- 步骤 9: 旋转到中间位置 ---
        elif clamp_step == 9:
            print("--- [Step 9] Action: Rotate arm to center position. ---")
            command = "#000P1500T1000!"
            print(f"[UART Send] Command: {command}")
            myUart.uart_send_str(command)
            print("[Wait] Waiting for 1 second...")
            time.sleep(1)
            clamp_step = 10

        # --- 步骤 10: 回到初始位置，重置流程 ---
        elif clamp_step == 10:
            print("--- [Step 10] Action: Return to initial position and reset process. ---")
            count += 1
            if count > 3:
                count = 0
            command = '{#000P1500T1000!#001P1500T1000!#002P2000T1000!#003P0750T1000!#004P1500T1000!#005P1500T1000!}'
            print(f"[UART Send] Command: {command}")
            myUart.uart_send_str(command)
            time.sleep(1)    
            print("--- Process cycle finished. Pausing thread and re-enabling image processing. ---")
            eEvent.clear() # 暂停当前线程
            Running = True # 重新开启图像处理
            clamp_step = 0 # 重置步骤
            time.sleep(2)
            
    
def distinguish_colorr(frame1):
    global Running,index,clamp_step,kms_x,kms_y,clamp_flag,count
    frame = frame1    
    if Running:
        frame = cv2.resize(frame, (320,240), interpolation = cv2.INTER_CUBIC) #将图片缩放到 320*240
        #1-高斯滤波GaussianBlur() 让图片模糊
        blur = cv2.GaussianBlur(frame,(5,5),0)
        #2-转换HSV的样式 以便检测
        hsv = cv2.cvtColor(blur,cv2.COLOR_BGR2HSV)
        
        for i in color_dists:
            
            #3-查找字典
            mask = cv2.inRange(hsv, color_dists[i]['Lower'], color_dists[i]['Upper'])
            
            #4-腐蚀图像
            mask = cv2.erode(mask,None,iterations=2)
                        
            #5-膨胀
            mask = cv2.dilate(mask, cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))) #膨胀
     
            #高斯模糊
            mask = cv2.GaussianBlur(mask,(3,3),0)
            #6-边缘检测
            cnts = cv2.findContours(mask.copy(),cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)[-2]                    
            
            #绘制矩形区域 frame图像，起点坐标，终点坐标
            #cv2.rectangle(frame,(40,60),(img_w-40,img_h-60),(0,0,0),1)           
            cv2.line(frame, (int(width / 2) - 10, int(hight / 2)), (int(width / 2) + 10, int(hight / 2)), (0, 0, 0), 1)
            cv2.line(frame, (int(width / 2),int(hight / 2) - 10), (int(width / 2), int(hight / 2) + 10), (0, 0, 0), 1)
            
            if len(cnts) >0 : #通过边缘检测来确定所识别物体的位置信息得到相对坐标

                cnt = max(cnts,key=cv2.contourArea)
                rect = cv2.minAreaRect(cnt)
                # 获取最小外接矩形的4个顶点
                box = cv2.boxPoints(rect)
                            
                #获取坐标 长宽 角度
                c_x, c_y = rect[0]
                c_h, c_w = rect[1]
                c_angle = rect[2]
                print(time.time(), 'x=', int(c_x), 'y=', int(c_y), 'c_h=', int(c_h), 'c_w=', int(c_w), 'angle=', int(c_angle))         
                #判断是否是方块大小且在方框中
                if 40 < c_x < 280 and 40 < c_y < 200:
                    #绘制轮廓
                    cv2.drawContours(frame, [np.int0(box)], -1, (0, 255, 255), 2)                   
                    index = -1
                    if i=='red':
                        index = 0
                    elif i=='green':
                        index = 1
                    elif i=='blue':
                        index = 2
                                
                    if index>=0:
                        axis_x_cur[index] = c_x
                        axis_y_cur[index] = c_y
                        if color_count[index]:
                            if abs(axis_x_cur[index]-axis_x_lst[index]) < 5 and abs(axis_y_cur[index]-axis_y_lst[index]) < 5:
                                color_count[index] = color_count[index]+1
                            else:
                                color_count[index] = 0
                        else:
                            color_count[index] = color_count[index]+1
                        axis_x_lst[index] = c_x
                        axis_y_lst[index] = c_y
                        
                        #判断数据稳定后开启搬运功能，
                        if color_count[index]>5:
                            
                            color_count[0]=0
                            color_count[1]=0
                            color_count[2]=0
                            get_kms_data(axis_x_lst[index],axis_y_lst[index],c_h,c_angle)
    return frame
                                                    
       

# def get_kms_data(c_x,c_y,c_h,c_angle):
#     global width,hight,clamp_flag,Running,clamp_step,place_step,kms_x,kms_y,servo_yuntai,servo_zhuazi
           
#     kms_x = (c_x-width/2+0)*30/c_h
#     kms_y = 160-((c_y-hight/2-0)*30/c_h)
#     #计算云台旋转角度
#     if(kms_x == 0 and kms_y != 0) :
#         theta6 = 0.0
#     elif(kms_y == 0 and kms_x > 0):
#         theta6 = 90
#     elif(kms_y == 0 and kms_x < 0):
#         theta6 = -90
#     else :
#         theta6 = atan(kms_x/kms_y)*180.0/pi
                       
#     servo_yuntai = int(1500-2000.0 * theta6/ 270.0)
#     print('servo_yuntai:', servo_yuntai)

#     #计算爪子旋转角度
#     if(c_angle<0):
#         c_angle = c_angle+90               
#     if (c_angle>45):
#         c_angle = 90-c_angle
       
#     if(theta6<0):
#         servo_zhuazi = int(1500+2000.0 * (-c_angle+abs(theta6))/ 270.0)
#         print("------------------------")
#     else:
#         servo_zhuazi = int(1500-2000.0 * (c_angle+abs(theta6))/ 270.0)
#         print("++++++++++++++++++++++")
     
#     clamp_step = 1
#     eEvent.set()  #线程旗标标志为真    
#     Running = False
    
#     debug = False
#     if debug:
#         print('kms_x:',kms_x,'kms_y:',kms_y)
#         print('theta6',theta6)
#         print('servo_yuntai:', servo_yuntai)                               
#         print('c_angle',c_angle)
#         print('servo_zhuazi:', servo_zhuazi)
#         print('kms_x1:',kms_x1,'kms_y1:',kms_y1)
#         Str = "#000P{0:0>4d}T{0:0>4d}!#004P{1:0>4d}T{2:0>4d}!#005P1200T{2:0>4d}!".format(servo_yuntai,servo_zhuazi, 1000)
        
#         kinematics_move(kms_x1,kms_y1,50,2000)
# 这里有过修正，非原版代码
def get_kms_data(c_x,c_y,c_h,c_angle):
    global width,hight,Running,clamp_step,kms_x,kms_y,servo_yuntai,servo_zhuazi
           
    # 步骤1: 像素坐标到物理坐标的转换
    kms_x = (c_x - width/2) * 30 / c_h
    kms_y = 160 - (c_y - hight/2) * 30 / c_h

    # 步骤2: 计算云台(ID 000)的旋转角度 theta6
    if kms_x == 0:
        theta6 = 0.0
    else:
        # 使用 atan2 来处理所有象限，更稳健
        theta6 = atan2(kms_x, kms_y) * 180.0 / pi
                       
    # 步骤3: 将云台角度转换为PWM值
    servo_yuntai = int(1500 - 2000.0 * theta6 / 270.0)

    # 步骤4: 计算爪子旋转舵机(ID 004)的角度
    # 将OpenCV输出的-90~0的角度，转换为0~90度
    if c_angle < 0:
        c_angle += 90               
    # 确保角度在0-90范围内，避免万向节锁问题
    if c_angle > 45:
        c_angle = 90 - c_angle
       
    # 爪子需要补偿云台的旋转角度，以保持面向前方
    # 注意: 这个补偿逻辑与具体的机械结构强相关，可能需要实际测试调整
    if theta6 < 0:
        servo_zhuazi = int(1500 + 2000.0 * (-c_angle + abs(theta6)) / 270.0)
    else:
        servo_zhuazi = int(1500 - 2000.0 * (c_angle + abs(theta6)) / 270.0)
     
    print(f"\n--- [Data Processed] ---")
    print(f"Pixel Coords (c_x, c_y): ({c_x:.2f}, {c_y:.2f})")
    print(f"Physical Coords (kms_x, kms_y): ({kms_x:.2f}, {kms_y:.2f})")
    print(f"Calculated Angles (theta6, c_angle): ({theta6:.2f}, {c_angle:.2f})")
    print(f"Calculated PWMs (Yuntai, Zhuazi): ({servo_yuntai}, {servo_zhuazi})")
    
    # 步骤5: 设置状态，触发机械臂运动
    clamp_step = 1
    eEvent.set()      # 唤醒 clamp_wood 线程
    Running = False   # 暂停图像处理
        
#逆运动学算法
def kinematics_move(x,y,z,mytime): 
    global servo_angle,servo_pwm
    if y < 0 :
        return 0
    #寻找最佳角度
    flag = 0
    my_min = 0
    for i in range(-135,0) :
        if 0 == kms.kinematics_analysis(x,y,z,i):
            if(i<my_min):
                my_min = i
            flag = 1
        
    #用3号舵机与水平最大的夹角作为最佳值
    if(flag) :
        kms.kinematics_analysis(x,y,z,my_min);
        testStr = '{'
        for j in range(0,4) :
            #set_servo(j, servo_pwm[j], time);
            #print(servo_pwm[j])
            testStr += "#%03dP%04dT%04d!" % (j,kms.servo_pwm[j],mytime)
        testStr += '}'
        print(testStr)
        myUart.uart_send_str(testStr)
        return 1
    
    return 0          

 #搬运线程
eEvent = threading.Event()
th1 = threading.Thread(target = clamp_wood)
th1.setDaemon(True)
th1.start()
    
#大循环
if __name__ == '__main__':
    myBeep.setup_beep()      #蜂鸣器初始化
    kms.setup_kinematics(170,105,75,185)
    myUart.setup_uart(115200) #设置串口
    #kinematics_move(-200,-10,20,2000)
    
   
    cam = Camera.Camera()  #摄像头库实例化    
    cam.camera_open()      #打开摄像头
      
    #机械臂蜷缩
    #myUart.uart_send_str('#000P{:0>4d}T1000!'.format(int(1500-2000.0 * 0/ 270.0)))
    
    #myUart.uart_send_str('#001P1300T1000!#002P1700T1000!#003P0600T1000!#004P1500T1000!#005P1500T1000!')
    myUart.uart_send_str('{#000P1500T1000!#001P1500T1000!#002P2000T1000!#003P0750T1000!#004P1500T1000!#005P1500T1000!}') 
    myBeep.beep(3,0.1)
   
    while 1:
         if cam.frame is not None:
            frame = cam.frame.copy()        
            distinguish_colorr(frame)
            cv2.imshow('frame',frame)
            if cv2.waitKey(5) & 0xFF == 27: #如果按了ESC就退出
                break
    myUart.uart_send_str('#000P1500T1000!#001P2150T1000!#002P2300T1000!#003P1000T1000!#004P1500T1000!#005P1500T1000!')
    cam.camera_close()
    cv2.destroyAllWindows()
    
