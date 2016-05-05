function [child1, child2]=crossover(parent1,parent2,I_Crossover)

load('usmap.mat','A');
A=triu(A);
[row,col]=find(A==1);

for i=I_Crossover
    [parent1(i), parent2(i)]=deal(parent2(i), parent1(i));
end

% Performing fitness based replacement

child1=parent1;
child2=parent2;

% % Evaluating fitness of children
% fitness_C1=sum(child1(row)~=child1(col));
% fitness_C2=sum(child1(row)~=child1(col));
% 
% % Evaluating the fitness of parents
% fitness_P1=sum(parent1(row)~=parent1(col));
% fitness_P2=sum(parent2(row)~=parent2(col));
% 
% fitmat=[fitness_P1, fitness_P2, fitness_C1, fitness_C2];
% [~,I]=sort(fitmat);
% familyMat=[parent1; parent2; child1; child2];
% child1=familyMat(I(3),:);
% child2=familyMat(I(4),:);


end