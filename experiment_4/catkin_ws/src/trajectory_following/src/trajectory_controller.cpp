#include <ros/ros.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/Pose.h>
#include <nav_msgs/Odometry.h>
#include <tf/tf.h>
#include <vector>
#include <string>
#include <cmath>

// 定义一个类来封装所有功能
class TrajectoryController {
public:
    TrajectoryController() {
        // 初始化节点句柄
        nh_ = ros::NodeHandle("~"); // 使用私有节点句柄获取参数

        // 初始化 Publisher 和 Subscriber
        vel_pub_ = nh_.advertise<geometry_msgs::Twist>("/mobile_base/commands/velocity", 10);
        odom_sub_ = nh_.subscribe("/odom", 10, &TrajectoryController::odomCallback, this);

        // 从参数服务器加载参数
        loadParams();

        // 等待里程计数据
        ros::topic::waitForMessage<nav_msgs::Odometry>("/odom");
    }

    // 主执行函数
    void run() {
        ros::Rate rate(20); // 控制频率 20Hz

        for (int i = 0; i < loop_count_; ++i) {
            ROS_INFO("--- Starting Trajectory Loop %d/%d ---", i + 1, loop_count_);
            for (const auto& shape : shape_sequence_) {
                // 记录每个形状的起始位姿，用于闭环修正
                geometry_msgs::Pose shape_start_pose = current_pose_;
                
                if (shape == "circle") {
                    executeCircle();
                } else if (shape == "star") {
                    executePolygon(5, star_side_length_, 2); // 五角星，跳2个顶点连接
                } else if (shape == "polygon") {
                    executePolygon(polygon_sides_, polygon_side_length_, 1); // 正多边形，跳1个顶点连接
                }
                
                // 完成一个形状后，返回到起始点进行误差修正
                ROS_INFO("Shape '%s' finished. Returning to start point for error correction.", shape.c_str());
                moveToGoal(shape_start_pose, 0.02);
            }
        }
        ROS_INFO("--- All trajectory loops completed. ---");
    }

private:
    // 里程计回调函数
    void odomCallback(const nav_msgs::Odometry::ConstPtr& msg) {
        current_pose_ = msg->pose.pose;
        current_yaw_ = tf::getYaw(current_pose_.orientation);
    }

    // 从参数服务器加载所有配置
    void loadParams() {
        nh_.param("shape_sequence", shape_sequence_, std::vector<std::string>{"circle"});
        nh_.param("loop_count", loop_count_, 1);
        nh_.param("speed", speed_, 0.2);
        nh_.param("turn_speed", turn_speed_, 0.5);
        nh_.param("circle_radius", circle_radius_, 1.0);
        nh_.param("star_side_length", star_side_length_, 1.0);
        nh_.param("polygon_sides", polygon_sides_, 4);
        nh_.param("polygon_side_length", polygon_side_length_, 1.0);
        ROS_INFO("Parameters loaded successfully.");
    }

    // 执行圆形轨迹（开环，因为是连续运动，误差较小）
    void executeCircle() {
        ROS_INFO("Executing Circle: radius=%.2f", circle_radius_);
        geometry_msgs::Twist vel_msg;
        vel_msg.linear.x = speed_;
        vel_msg.angular.z = speed_ / circle_radius_;

        double duration = 2 * M_PI * circle_radius_ / speed_;
        ros::Time start_time = ros::Time::now();
        while (ros::ok() && (ros::Time::now() - start_time).toSec() < duration) {
            vel_pub_.publish(vel_msg);
            ros::spinOnce();
            ros::Rate(20).sleep();
        }
        stop();
    }
    
    // 执行多边形/星形轨迹（闭环）
    void executePolygon(int sides, double length, int vertex_skip) {
        ROS_INFO("Executing Polygon/Star: sides=%d, length=%.2f", sides, length);
        double turn_angle = (2.0 * M_PI * vertex_skip) / sides;
        
        for (int i = 0; i < sides; ++i) {
            // 1. 计算直线段的目标点
            geometry_msgs::Pose side_goal_pose = current_pose_;
            side_goal_pose.position.x += length * cos(current_yaw_);
            side_goal_pose.position.y += length * sin(current_yaw_);
            
            // 2. 移动到目标点
            moveToGoal(side_goal_pose, 0.05);
            stop();
            
            // 3. 计算旋转后的目标角度
            double turn_goal_yaw = normalizeAngle(current_yaw_ + turn_angle);
            
            // 4. 旋转到目标角度
            rotateToGoal(turn_goal_yaw, 0.05);
            stop();
        }
    }

    // P控制器：移动到目标位姿
    void moveToGoal(const geometry_msgs::Pose& goal, double dist_tolerance) {
        ros::Rate rate(20);
        while (ros::ok() && getDistance(current_pose_.position, goal.position) > dist_tolerance) {
            double angle_to_goal = atan2(goal.position.y - current_pose_.position.y,
                                         goal.position.x - current_pose_.position.x);
            double angle_error = normalizeAngle(angle_to_goal - current_yaw_);
            
            geometry_msgs::Twist vel_msg;
            vel_msg.linear.x = std::min(speed_, 1.5 * getDistance(current_pose_.position, goal.position));
            vel_msg.angular.z = 2.0 * angle_error;
            
            // 如果角度误差太大，优先旋转
            if (std::abs(angle_error) > M_PI / 4) {
                vel_msg.linear.x = 0;
            }

            vel_pub_.publish(vel_msg);
            ros::spinOnce();
            rate.sleep();
        }
    }

    // P控制器：旋转到目标角度
    void rotateToGoal(double goal_yaw, double angle_tolerance) {
        ros::Rate rate(20);
        while (ros::ok() && std::abs(normalizeAngle(goal_yaw - current_yaw_)) > angle_tolerance) {
            double angle_error = normalizeAngle(goal_yaw - current_yaw_);
            
            geometry_msgs::Twist vel_msg;
            vel_msg.angular.z = (angle_error > 0) ? std::min(turn_speed_, 2.0 * angle_error) : std::max(-turn_speed_, 2.0 * angle_error);
            
            vel_pub_.publish(vel_msg);
            ros::spinOnce();
            rate.sleep();
        }
    }

    // 辅助函数
    double getDistance(const geometry_msgs::Point& p1, const geometry_msgs::Point& p2) {
        return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
    }

    double normalizeAngle(double angle) {
        while (angle > M_PI) angle -= 2.0 * M_PI;
        while (angle < -M_PI) angle += 2.0 * M_PI;
        return angle;
    }
    
    void stop() {
        vel_pub_.publish(geometry_msgs::Twist());
        ros::Duration(0.5).sleep(); // 短暂暂停
    }

    // 成员变量
    ros::NodeHandle nh_;
    ros::Publisher vel_pub_;
    ros::Subscriber odom_sub_;
    geometry_msgs::Pose current_pose_;
    double current_yaw_;

    // 参数
    std::vector<std::string> shape_sequence_;
    int loop_count_;
    double speed_;
    double turn_speed_;
    double circle_radius_;
    double star_side_length_;
    int polygon_sides_;
    double polygon_side_length_;
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "trajectory_controller_node");
    TrajectoryController controller;
    controller.run();
    return 0;
}
