function fitness=costFunction(population)

X=population(:,1);
Y=population(:,2);

fitness=-(sin(X).*sin(2*Y) + 0.3*X);
end
