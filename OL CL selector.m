function [R1,R2,R3,R4] = fcn(OL,CL)
if OL(1)>CL(1)
    R1=CL(1);
else
    R1=OL(1);
end

if OL(2)>CL(2)
    R2=CL(2);
else
    R2=OL(2);
end
if OL(3)>CL(3)
    R3=CL(3);
else
    R3=OL(3);
end
if OL(4)>CL(4)
    R4=CL(4);
else
    R4=OL(4);
end


