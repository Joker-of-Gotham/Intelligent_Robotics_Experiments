import sys
sys.path.append('/home/pi/Desktop/Robot_Experiment/Lib/')
import time
import UartServer

'''
通过串口发送指令控制电机的转速,时间
参数：
speed:-1000~1000,负值后退，正值前进，绝对值越大转速越高。
time: 代表车轮转动时间，0代表一直转动，1000代表转动1秒，以此类推。
'''
#开始

#小车运行函数，请修改该函数使得该函数可以驱动四个电机旋转
def run(speed,time):
    Car_Control_Cmd = '#006P{0:0>4d}T{2:0>4d}!#007P{1:0>4d}T{2:0>4d}!'.format(1500+speed,1500-speed,time)
    print(Car_Control_Cmd)
    UartServer.uart_send_str(Car_Control_Cmd)

#小车停止
def stop():
    run(0,1000)

#测试函数，请调用run函数来补充该函数，使得小车能够实现前进、后退、左平移、右平移、左旋转、右旋转
def test():
    run(500,1000)
    time.sleep(2)
    stop()

#结束
    
if __name__ == '__main__':
    UartServer.setup_uart(115200) #设置串口
    test()
    try:
        while True:
            pass
    except KeyboardInterrupt:
        destory() 
    
    
    
    