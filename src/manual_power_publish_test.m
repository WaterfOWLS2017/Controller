function [ output_args ] = manual_power_publish_test( pow1, pow2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
rate = 10; % Hz

try
    rosinit('192.168.0.10');
catch exception
end

testpub = rospublisher('/motor_power', 'motors/MotorPower');
msg = rosmessage('motors/MotorPower');

msg.Power1 = pow1;
msg.Power2 = pow2;

while(1)
    send(testpub, msg);
    display(msg)
    pause(1);
end

end

