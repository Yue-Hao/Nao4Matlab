% by Hao Yue % Nov,21,2012
%% plot the robot skeleton
function PlotSkeleton(j)

global uLINK

if j == 0
    return;
end

hold on

if ~isempty(uLINK(j).skeleton)
    ShowSkeleton(j);
end

PlotSkeleton(uLINK(j).sister);
PlotSkeleton(uLINK(j).child);
hold off
    
end