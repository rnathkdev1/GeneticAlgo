clc; clear;
%% Declaring the quantities
H=275;      P=2000;             E=900000; 
d1=1;       d2=10;              t1=0.1;
t2=1;       sigma_yield=550;    ro=0.0025;

x0=[2;0.6];
x0_=[2.5;0.9];
%% Using the Active Set Algorithm using fmincon
options=optimoptions('fmincon','Algorithm','active-set');


% x=fmincon(@costFunction,x0)

[x,fval] = fmincon(@costFunction,x0,[],[],[],[],[],[], ...
           @NL_inequality,options);
       
%% Using the SQP Algorithm
options2=optimoptions('fmincon','Algorithm','sqp');

[x_,fval_] = fmincon(@costFunction,x0,[],[],[],[],[],[], ...
           @NL_inequality,options2);
       
%% Using the Active Set Algorithm using fmincon
options=optimoptions('fmincon','Algorithm','active-set');


% x=fmincon(@costFunction,x0)

[x__,fval__] = fmincon(@costFunction,x0_,[],[],[],[],[],[], ...
           @NL_inequality,options);
       
%% Using the SQP Algorithm
options2=optimoptions('fmincon','Algorithm','sqp');

[x___,fval___] = fmincon(@costFunction,x0_,[],[],[],[],[],[], ...
           @NL_inequality,options2);
       
       
clc;
%% Output the answer for the first set of initial values
disp('First set of Initial values');
fprintf('Using Active-Set, the optimal value of the function is at [%f,%f] and the optimal value is %f\n',x(1),x(2),fval);
fprintf('Using SQP Algorithm, the optimal value of the function is at [%f,%f] and the optimal value is %f\n\n\n',x_(1),x_(2),fval_);

%% Output the answer for the second set of initial values
disp('Second Set of Initial Values');
fprintf('Using Active-Set, the optimal value of the function is at [%f,%f] and the optimal value is %f\n',x__(1),x__(2),fval__);
fprintf('Using SQP Algorithm, the optimal value of the function is at [%f,%f] and the optimal value is %f\n',x___(1),x___(2),fval___);

