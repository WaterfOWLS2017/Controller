function controller_handler(src, msg, varargin)
    motorcmd = varargin{1};
    cmd = rosmessage('ros_custom_messages/MotorPower');
    if msg.Xcoord == 0
        cmd.Power1 = 0.2;
        cmd.Power2 = 0.2;
    elseif msg.Xcoord < 0
        cmd.Power1 = 0.7;
        cmd.Power2 = 0.0;
    else
        cmd.Power1 = 0.0;
        cmd.Power2 = 0.7;
    end
    send(motorcmd, cmd);
end