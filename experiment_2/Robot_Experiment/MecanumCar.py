import sys
sys.path.append('/home/pi/Desktop/Robot_Experiment/Lib/')
import time
import UartServer

'''
通过串口发送指令控制电机的转速,时间
参数：
speed: -1000~1000, 负值后退，正值前进，绝对值越大转速越高。
time: 代表车轮转动时间，0代表一直转动，1000代表转动1秒，以此类推。
'''
#开始

# ==============================================================================
#                                   重要参数定义
# ==============================================================================
# 根据手册 表2，定义四个车轮电机的ID
MOTOR_ID_LEFT_FRONT = 6
MOTOR_ID_RIGHT_FRONT = 7
MOTOR_ID_LEFT_REAR = 8
MOTOR_ID_RIGHT_REAR = 9

# ==============================================================================
#                                   核心运动函数
# ==============================================================================

# 小车运行函数，已修改为可以驱动四个电机，并支持多种运动模式
def run(mode, speed, run_time):
    """
    控制小车运动的核心函数。
    :param mode: 字符串，运动模式，可选值:
                 "forward", "backward", "shift_left", "shift_right",
                 "turn_left", "turn_right", "stop"
    :param speed: int, 速度值 (0-1000), 代表运动的快慢
    :param run_time: int, 运行时间 (ms), 1000 代表1秒
    """
    # 确保速度是正值，方向由mode决定
    speed = abs(speed)

    # 根据手册，左右两侧电机正转定义相反
    # 左侧电机: 1500 - speed 为前进方向
    # 右侧电机: 1500 + speed 为前进方向
    
    # 初始化四个电机的PWM值，1500为停止
    pwm_left_front = 1500
    pwm_right_front = 1500
    pwm_left_rear = 1500
    pwm_right_rear = 1500

    # 根据不同的运动模式，设置四个电机的PWM值
    if mode == "forward":
        pwm_left_front = 1500 - speed
        pwm_right_front = 1500 + speed
        pwm_left_rear = 1500 - speed
        pwm_right_rear = 1500 + speed
    elif mode == "backward":
        pwm_left_front = 1500 + speed
        pwm_right_front = 1500 - speed
        pwm_left_rear = 1500 + speed
        pwm_right_rear = 1500 - speed
    elif mode == "shift_left":
        pwm_left_front = 1500 + speed  # 后退
        pwm_right_front = 1500 + speed  # 前进
        pwm_left_rear = 1500 - speed   # 前进
        pwm_right_rear = 1500 - speed   # 后退
    elif mode == "shift_right":
        pwm_left_front = 1500 - speed   # 前进
        pwm_right_front = 1500 - speed   # 后退
        pwm_left_rear = 1500 + speed  # 后退
        pwm_right_rear = 1500 + speed  # 前进
    elif mode == "turn_left":
        pwm_left_front = 1500 + speed  # 后退
        pwm_right_front = 1500 + speed  # 前进
        pwm_left_rear = 1500 + speed  # 后退
        pwm_right_rear = 1500 + speed  # 前进
    elif mode == "turn_right":
        pwm_left_front = 1500 - speed   # 前进
        pwm_right_front = 1500 - speed   # 后退
        pwm_left_rear = 1500 - speed   # 前进
        pwm_right_rear = 1500 - speed   # 后退
    elif mode == "stop":
        # 所有PWM值保持1500即可
        pass
    else:
        print("未知的运动模式:", mode)
        return

    # 格式化并拼接成最终的串口指令字符串
    # 格式: #<id1>P<pwm1>T<time>!#<id2>P<pwm2>T<time>!...
    Car_Control_Cmd = (
        f"#{MOTOR_ID_LEFT_FRONT:03d}P{pwm_left_front:04d}T{run_time:04d}!"
        f"#{MOTOR_ID_RIGHT_FRONT:03d}P{pwm_right_front:04d}T{run_time:04d}!"
        f"#{MOTOR_ID_LEFT_REAR:03d}P{pwm_left_rear:04d}T{run_time:04d}!"
        f"#{MOTOR_ID_RIGHT_REAR:03d}P{pwm_right_rear:04d}T{run_time:04d}!"
    )
    
    # 打印指令并发送
    print(f"执行动作: {mode.upper()}, 指令: {Car_Control_Cmd}")
    UartServer.uart_send_str(Car_Control_Cmd)

# 小车停止函数
def stop():
    run("stop", 0, 0) # 速度为0，时间为0表示一直停止

# ==============================================================================
#                                   测试函数
# ==============================================================================
# 测试函数，已补充完整，按顺序实现六个目标动作
def test():
    base_speed = 500      # 基础速度
    run_duration = 1000   # 每个动作持续1秒 (1000ms)
    pause_duration = 2    # 每个动作之间的停顿时间 (2秒)

    print("--- 开始执行六项基本动作测试 ---")

    # 1. 前进
    print(f"\n1. 前进 {run_duration/1000} 秒...")
    run("forward", base_speed, run_duration)
    time.sleep(pause_duration)

    # 2. 后退
    print(f"\n2. 后退 {run_duration/1000} 秒...")
    run("backward", base_speed, run_duration)
    time.sleep(pause_duration)
    
    # 3. 左平移
    print(f"\n3. 左平移 {run_duration/1000} 秒...")
    run("shift_left", base_speed, run_duration)
    time.sleep(pause_duration)

    # 4. 右平移
    print(f"\n4. 右平移 {run_duration/1000} 秒...")
    run("shift_right", base_speed, run_duration)
    time.sleep(pause_duration)

    # 5. 左旋转
    print(f"\n5. 左旋转 {run_duration/1000} 秒...")
    run("turn_left", base_speed, run_duration)
    time.sleep(pause_duration)

    # 6. 右旋转
    print(f"\n6. 右旋转 {run_duration/1000} 秒...")
    run("turn_right", base_speed, run_duration)
    time.sleep(pause_duration)
    
    # 所有动作完成后停止
    print("\n--- 测试完成，小车停止 ---")
    stop()

#结束

# ==============================================================================
#                                   主程序入口
# ==============================================================================
if __name__ == '__main__':
    try:
        UartServer.setup_uart(115200) # 设置串口
        test() # 执行测试序列
    except Exception as e:
        print(f"程序出错: {e}")
    finally:
        print("程序结束，确保小车已停止。")
        stop() # 增加一层保障，确保程序退出时小车停止