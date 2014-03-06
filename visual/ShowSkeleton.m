% by Hao Yue % Nov,21,2012
function h = ShowSkeleton(object)
global uLINK

if object <= 0
    return;
end

vert = uLINK(object).R * uLINK(object).skeleton.vertex;
vert = vert + repmat(uLINK(object).p,1,size(vert,2));

h = patch('faces',uLINK(object).skeleton.face,'vertices',vert','FaceColor',[0.5 0.5 0.5]);

end