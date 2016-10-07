rosinit('192.168.0.10');
motorcmd = rospublisher('/motor_power', 'ros_custom_messages/MotorPower');
rossubscriber('/cv_test', {@controller_handler, motorcmd});