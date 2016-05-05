function [child1, child2]=crossover(parent1,parent2)

% Using Line Crossover
% Generate an alpha
alpha=rand;
child1=alpha*parent1+(1-alpha)*parent2;
child2=(1-alpha)*parent1+alpha*parent2;


end