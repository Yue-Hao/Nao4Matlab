function Struct = MakeStruct(TransMat)

Struct.R = TransMat(1:3,1:3);
Struct.p = TransMat(1:3,4);

end
