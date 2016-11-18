function motor_gui_callback( ax, ~ )
%motor_gui_callback callback function for when the plot is clicked
%   Detailed explanation goes here
    global x;
    global y;
    point_info = get(ax, 'CurrentPoint');
    point_info = point_info(1,1:2);
    x = point_info(1);
    y = point_info(2);
end