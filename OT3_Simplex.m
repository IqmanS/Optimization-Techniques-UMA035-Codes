%Simplex method
clc
clear all
% cost=[2 5 0 0 0 0];
% a=[1 4 1 0 0; 3 1 0 1 0; 1 1 0 0 1];
% b=[24; 21; 9];
% c=[20 10];
% A=[1 2;3 1;4 3];
% b=[40;30;60];
% cost=[100 125 0 0 0 0];
% a=[8 5 1 0 0;10 6 0 1 0;4 12 0 0 1];
% b=[800;600;720];
% cost=[5 3 0 0 0 0];
% a=[1 1 1 0 0;5 2 0 1 0;2 8 0 0 1];
% b=[2;10;12];
cost=[4 10 0 0 0 0];
 a=[2 1 1 0 0;2 5 0 1 0;2 3 0 0 1];
 b=[50;100;90];
A=[a b];
 Var={'x1','x2','s1','s2','s3','sol'}
 bv=[3 4 5];
% cost=[5 4 0 0 0 0 0]
% a=[6 4 1 0  0 0;1 2 0 1 0 0; -1 1 0 0 1 0; 0 1 0 0 0 1];
% b=[24;6;1;6]
% A=[a b];
% bv=[3 4 5 6];
% Var={'x1','x2','s1','s2','s3','s4','sol'}
zjcj=cost(bv)*A-cost;
% Display initial simplex table
simplex_table=[zjcj; A];
array2table(simplex_table,'VariableNames',Var)
RUN=true;
 while RUN
if any(zjcj(1:end-1)<0) % check for negative value
 fprintf(' The current BFS is not optimal \n');
 zc=zjcj(1:end-1);
 [Enter_val, pvt_col]= min(zc) ;
 if all(A(:,pvt_col)<=0)
  error('LPP is Unbounded');
 else
 sol=A(:,end);
 column=A(:,pvt_col);
  for i=1:size(A,1)
 if column(i)>0   % pivot column value positive
 ratio(i)= sol (i)./column(i);
 else
 ratio(i)=inf;
 end
  end 
  [leaving_value,pvt_row]=min(ratio);
 end
 bv(pvt_row)=pvt_col;    % replaced leaving variable with entering variable
 pvt_key=A(pvt_row, pvt_col);
 A(pvt_row,:)=A (pvt_row,:)./pvt_key;
 % row operation 
for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)-A (i, pvt_col).*A(pvt_row,:);
 end
end
 zjcj=cost(bv)*A-cost;
 next_table=[zjcj; A];
array2table(next_table,'VariableNames',Var)

else
    RUN=false;
    fprintf('The table is optimal \n');
    z=input(' Enter 0 for minimization and 1 for max \n');
    if z==0
        Obj_value=-zjcj(end);
    else
        Obj_value=zjcj(end);
    end
    fprintf('The final optimal value is % f \n',Obj_value);
end
 end