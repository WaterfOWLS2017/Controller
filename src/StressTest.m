%% user config
amplitude_min = 0.1;
amplitude_max = 0.5;
duration_min = 0.5;
duration_max = 5;
rand_direction = 1;
% end config

%% setup ROS connection
try
    rosinit('http://192.168.0.10:11311');
catch
end
onCleanup(@rosshutdown);
motor_service = rossvcclient('/motor_power');

%% main stress test loop
while true
    try
        request = rosmessage(client);
        request.PowerL = rand_range(amplitude_min, amplitude_max);
        if (rand_direction && rand() < 0.5)
            request.PowerL = -request.PowerL;
        end
        request.PowerR = rand_range(amplitude_min, amplitude_max);
        if (rand_direction && rand() < 0.5)
            request.PowerR = -request.PowerR;
        end
        request.Duration = inf;
        call(motor_service, request);
        pause(rand_range(duration_min, duration_max));
    catch
        break
    end
end

%% convenience functions
function a = rand_range(mn, mx)
    a = (mx-mn)*rand()+mn;
end