function qddot  = fcn(qdot,q,R,q0,q0dot,C1,C2)
% this function will calculate the 2nd order derivative of q(qddot) using
%   the equation M(q)*qddot + C(q,qdot) + G(q)=F(q)
% Each of these terms has to be calculated first before proceeding to the
%   calcutation of qddot
%--------------------------------------------
% 1.setup
    qddot=[0,0,0]';
    J=[1,0,0;0,1,0;0,0,1];
    h=0.4;
    f=0.01;
    A1=[0,0,0;0,-C1,0;0,0,-C1];
    A2=[0,0,0;0,-C2,0;0,0,-C2];
    W=[1,0,-sin(q(2));0,-cos(q(1)),sin(q(1))*cos(q(2));0,-sin(q(1)),cos(q(1))*cos(q(2))];
    B=[-f,f,-f,f;-h,0,h,0;0,-h,0,h];
    

%--------------------------------------------
% 2.calculation of F(q) using formula F(q)=T(q)+A(q)
    A=A1*(q-q0) +A2*(qdot-q0dot);
    T=W*B*R;
    F=T+A;
%--------------------------------------------
% 3. Calculation of M(q) 
    M=transpose(W)*J*W;
%--------------------------------------------
% 4. Calculation of C(q,qdot)
    i=1;
    j=1;
    k=1;
    for i=1:3
        for j=1:3
            for k=1:3
                C(i,j)=0.5*((diff(M(i,j))/diff(q(k)))+(diff(M(i,j))/diff(q(k)))-(diff(M(i,j))/diff(q(k))))
    
%--------------------------------------------
% 5. final calculation 
    syms t;
    ode=M*diff(diff(q(1),t))+C*diff(q(1),t)==F;
    qddot(1)=dsolve(ode);
    ode=M*diff(diff(q(2),t))+C*diff(q(2),t)==F;
    qddot(2)=dsolve(ode);
    ode=M*diff(diff(q(3),t))+C*diff(q(3),t)==F;
    qddot(3)=dsolve(ode);
