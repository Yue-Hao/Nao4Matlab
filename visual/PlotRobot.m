% by Hao Yue % Nov,21,2012
%% plot the robot skeleton
function PlotRobot(j)

global uLINK

if j == 0
    return;
end
hold on
ShowObject(j);
PlotRobot(uLINK(j).sister);
PlotRobot(uLINK(j).child);
hold off
    
end