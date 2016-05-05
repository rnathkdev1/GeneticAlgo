function cost= costFunction(x)

ro=0.0025;
H=275;
% x=[d;t];
%  
cost=4*ro*pi*H*(x(1)*x(2) + x(2)^2) + 2*x(1);

end