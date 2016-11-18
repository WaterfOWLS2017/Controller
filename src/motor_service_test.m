%setenv('ROS_MASTER_URI', 'http://192.168.0.10:11311')
try
    rosinit('http://192.168.0.10:11311');
catch
end
motor_client = rossvcclient('/motor_power2', 'Timeout', 3);


motor_req = rosmessage(motor_client);
motor_req.PowerL = 0.05;
motor_req.PowerR = 0.05;
motor_req.Duration = 10;


motor_resp = call(motor_client, motor_req)
rosshutdown