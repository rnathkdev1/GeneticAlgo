function [c,ceq]=NL_inequality(x)
% x has the form [d;t]

H=275;      P=2000;             E=900000;
d1=1;       d2=10;              t1=0.1;
t2=1;       sigma_yield=550;    ro=0.0025;

% Compressive stress < yield stress
c(1)= P/(pi*x(1)*x(2)) -sigma_yield;

% Buckling Stress < Compressive Stress
c(2)=x(1)*x(2)*(x(1)^2 + x(2)^2) - 8*P*H^2/(pi^3*E);

% Buckling<yield
c(2)=pi^2*E*(x(1)^2+x(2)^2)/(8*H^2) - sigma_yield;

%Limits on d and t
c(3)=x(1)-d2;
c(4)=d1-x(1);
c(5)=x(2)-t2;
c(6)=t1-x(2);

ceq=[];
end
