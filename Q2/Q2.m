clc; clear;
%% Initializing values
H=[1 0;0 9];
f=[3.2;-6];
A=[-1 -3;2 5; 3 4];
b=[-15;100;80];
x0=[0;0];
%% Using quadprog
options=optimoptions(@quadprog,'Algorithm','interior-point-convex');
[x,fval]=quadprog(H,f,A,b,[],[],[],[],x0,options);
fval=fval+7;
%% Using fmincon

[x_,fval_]=fmincon(@costfunction,x0,A,b);
fval_=fval_+7;
clc;

fprintf('Using Quadprog, the optimal value of the function is at [%f,%f] and the optimal value is %f\n',x(1),x(2),fval);
fprintf('Using fmincon, the optimal value of the function is at [%f,%f] and the optimal value is %f\n',x_(1),x_(2),fval_);
