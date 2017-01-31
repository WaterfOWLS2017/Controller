function thrust_test()

    function cv_callback(src, msg)
        cellBlobs = {msg.Blobs};
    end
    % set up ros global node if it's not already
    try
        rosinit('http://192.168.0.10:11311');
    catch
    end

    % create a motor_client to conect to the motor service
    motor_client = rossvcclient('/motor_power2', 'Timeout', 3);
    motor_req = rosmessage(motor_client);

    rossubscriber('/cv_test', @cv_callback);

    through_course = 0;
    through_first_gate = 0;
    highest_num_buoys = 0;
    cellBlobs = {};

    % main loop
    while(~through_course)
        num_buoys = size(cellBlobs);

        if(~through_first_gate)
            highest_num_buoys = max(highest_num_buoys, num_buoys);
            
            % if we haven't found the start gate yet
            if(num_buoys < 2 && highest_num_buoys < 2)
                % turn the boat in place until we do find them
                motor_req.PowerL = 0.3;
                motor_req.PowerR = -0.3;
            elseif(num_buoys < 2 && highest_num_buoys >= 2)
                through_first_gate = 1;
                motor_req.PowerL = 0.3;
                motor_req.PowerR = 0.3;
            else % we see at least 2 buoys
                
                % sort the buoy array based on size
                
                % get the color of the two closes buoys
                
                % check to see if the two closest are different colors
                if(~strcmp(color1, color2)
                    % if they aren't, we've found our starting gate
                    % drive towards it
                    motor_req.PowerL = 0.3;
                    motor_req.PowerR = 0.3;
                
                % if the two closest buoys are the same color, keep turning
                else
                    motor_req.PowerL = 0.3;
                    motor_req.PowerR = -0.3;
                end
            end
        else
            motor_req.PowerL = 0.3;
            motor_req.PowerR = 0.3;
        end


        % set the duration to be 1/2 a second - should get updated by next 
        % iteration before time runs out though
        motor_req.Duration = 0.5;
        motor_resp = call(motor_client, motor_req); % send the request

        pause(1/20); % pause to create 20Hz loop
    end

    rosshutdown
end
