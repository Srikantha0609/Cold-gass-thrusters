function R = fcn(Tb,phi)
R=[0,0,0,0];
%input parameters
minratio=0;
pivotrow=[0,0,0,0,0,0,0,0];
pivotcol=[0,0,0,0]
h=0.4;
Noofvariables=4;
f=0.01;
C=[1,1,1,1];
info=[-sin(phi),-cos(phi),sin(phi),cos(phi);-cos(phi),sin(phi),cos(phi),-sin(phi);-f,f,-f,f];
s=eye(3);
b=[Tb(3)/h,Tb(2)/h,Tb(1)]';
tableS=zeros(4,8);


%computation
A=[info,s,b];
Cost=zeros(1,size(A,2));
Cost(1:Noofvariables)=C;
BV=5:1:7;
zjcj=Cost(BV)*A-Cost;
BFS=zeros(1,size(A,2));
zcj=[zjcj;A];
tableS=array2table(zcj,'VariableNames',{'x_1','x_2','x_3','x_4','s_1','s_2','s_3','solu'});
%tableS=array2table(zcj);
%tableS.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','x_3','x_4','s_1','s_2','s_3','solu'};
zc=zjcj(1:size(zjcj,2)-1);
run=true;
while run
    if any(zjcj<0)
        [minvalue,pivotcol]=min(zc);
        sol=A(:,end);
        column=A(:,pivotcol);
        ratio=zeros(1,3);
        for i=1:size(column,1)
            if column(i)>0
                ratio(i)=sol(i)./column(i);
            else
                ratio(i)=inf;
            end
        end
        %finding the pivot row
        [minratio,pivotrow]=min(ratio);
        BV(pivotrow)=pivotcol;
        pivotkey=A(pivotrow,pivotcol);
        %A(pivotrow,:) = A(pivotrow,:)/pivotkey;
        for i=1:size(A,2)
            A(pivotrow,i)=A(pivotrow,i)/pivotkey;
        end
        for i=1:size(A,1)
            if i~=pivotrow
                A(i,:)=A(i,:)-A(i,pivotcol).*A(pivotrow,:);
            end
                zjcj=zjcj-zjcj(pivotcol).*A(pivotrow,:);
        end 
        
        zcj=[zjcj;A];
        tableS=array2table(zcj,'VariableNames',{'x_1','x_2','x_3','x_4','s_1','s_2','s_3','solu'});
        %tableS.Properties.VariableNames(1:size(zcj,2))={'x_1','x_2','x_3','x_4','s_1','s_2','s_3','solu'};
        
        BFS(BV)=A(:,end);
        BFS(end)=sum(BFS.*Cost);
        CurrentBFS=array2table(BFS,'VariableNames',{'x_1','x_2','x_3','x_4','s_1','s_2','s_3','solu'});
        %CurrentBFS=array2table(BFS);
        %CurrentBFS.Properties.VariableNames(1:size(CurrentBFS,2))={'x_1','x_2','x_3','x_4','s_1','s_2','s_3','solu'};
    else
        run=false;
        R=BFS(1:4);
  
    end
end
