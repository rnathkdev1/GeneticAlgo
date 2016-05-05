function cost=costfunction(x)
H=[1 0;0 9];
f=[3.2;-6];

cost=0.5*x'*H*x + f'*x;

end
