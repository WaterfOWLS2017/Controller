clear;

try
    rosinit('192.168.0.10');
catch exception
end

cleanupObj = onCleanup('rosshutdown');

motor_power_pub = rospublisher('/motor_power', 'motors/MotorPower');
motor_power_msg = rosmessage('motors/MotorPower');

global x; 
global y;
x = 0; 
y = 0;

figure(1); clf;
axis([-1,1,-1,1]);
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
set(ax, 'ButtonDownFcn', @motor_gui_callback);

while(1)
    pow1 = y * (x+1)/2
    pow2 = y* (-1*x + 1)/2
    
    % round powers down if too low to prevent
    % motor stuttering
    if(abs(pow1) < .03)
        pow1 = 0;
    end
    if(abs(pow2) < .03)
        pow2 = 0;
    end
    
    pause(.1);
    
    motor_power_msg.Power1 = pow1;
    motor_power_msg.Power2 = pow2;
    send(motor_power_pub, motor_power_msg);
end