#include <ros/ros.h>
#include <geometry_msgs/Twist.h>

#define PI 3.1415926535
#define RATE 10
#define SPEED 0.2


// 角度转换为弧度
double radians(double deg);


int main(int argc, char **argv)
{
    double length;  // 矩形轨迹的长
    double width;   // 矩形轨迹的宽

    // ROS节点初始化
    ros::init(argc, argv, "rectangle_trajectory");

    // 创建节点句柄
    ros::NodeHandle nh;

    // 获取参数（与rectangle.launch文件中对应）
    nh.getParam("/length", length);
    nh.getParam("/width", width);

    // 创建一个Publisher，主题名为 /mobile_base/commands/velocity
    ros::Publisher vel_pub = nh.advertise<geometry_msgs::Twist>("/mobile_base/commands/velocity", 10);

    // 设置循环频率
    ros::Rate rate(RATE);

    // 前进速度
    geometry_msgs::Twist vel_msg_move;
    vel_msg_move.linear.x = SPEED;
    vel_msg_move.angular.z = 0.0;

    // 转弯速度
    geometry_msgs::Twist vel_msg_turn;
    vel_msg_turn.linear.x = 0.0;
    vel_msg_turn.angular.z = radians(45);

    // 矩阵轨迹跟随
    int count = 0;
    while (ros::ok())
    {
        int time = 0;
        if (count % 2 == 0)  // 长边
        {
            double seconds = length / SPEED;
            time = int(seconds * RATE);
        }
        else                 // 短边
        {
            double seconds = width / SPEED;
            time = int(seconds * RATE);
        }

        // 前进
        ROS_INFO("Going Straight");
        for (int i = 0; i < time; i++)
        {
            vel_pub.publish(vel_msg_move);
            rate.sleep();
        }

        // 转弯
        ROS_INFO("Turning");
        for (int i = 0; i < 2 * RATE; i++)
        {
            vel_pub.publish(vel_msg_turn);
            rate.sleep();
        }

        count = (count + 1) % 4;
        if (count == 0)
        {
            ROS_INFO("Turtlebot2 should be close to the original starting position (but it's probably way off)");
        }
    }
}

double radians(double deg) 
{
    double rad = deg * PI / 180;
    return rad;
}
