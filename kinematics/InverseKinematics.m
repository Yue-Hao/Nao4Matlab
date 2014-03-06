% by Hao Yue % Nov,21,2012
% function InverseKinematics(to, Target)
% 
% global uLINK
% 
% lambda = 0.5;
% 
% ForwardKinematics(1);
% idx = FindRoute(to);
% 
% for n = 1:10
%     J = CalcJacobian(idx);
%     err = CalcVWerr(Target,uLINK(to));
%     if norm(err) < 1E-6
%         return;
%     end
%     dq = lambda * (J \ err);
%     for nn = 1:length(idx)
%         j = idx(nn);
%         uLINK(j).q = uLINK(j).q + dq(nn);
%     end
%     ForwardKinematics(1);
% end

function res = InverseKinematics(to, Target)

global uLINK

lambda = 0.5;
ForwardKinematics(1);
idx = FindRoute(to);
idx

for n = 1:30
    J = CalcJacobian(idx);
    %J
    err = CalcVWerr(Target, uLINK(to));
    if norm(err) < 1E-3
        fprintf('Success %d\n',n);
        res = 1;
        return;
    end
    dq = lambda * (J \ err);
    dq = rad2deg(dq);
    for nn = 1:length(idx)
        j = idx(nn);
        uLINK(j).q = NormailzeAngle(uLINK(j).q + dq(nn));
%         
%         if uLINK(j).q > uLINK(j).max
%             uLINK(j).q = uLINK(j).max;
%         end
%         if uLINK(j).q < uLINK(j).min
%             uLINK(j).q = uLINK(j).min;
%         end
    end
    ForwardKinematics(1);
end
fprintf('Fail\n');
res = 0;