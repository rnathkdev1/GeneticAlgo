function [solution,score] = ga_mapcoloring_florida(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear;

load('usmap.mat');
CR=0.9;
PopSize=500;
tournamentSize=ceil(0.02*PopSize);
Elitism=2;

% Choosing a data representation
% One member of the population is an array of length 50 and having numbers
% 1 to 4. Population size = 500

A=triu(A);
population=randi(4,PopSize,50);

% Reinforcing Florida-Penn Constraint
population(:,33)=1;
population(:,40)=1;

[row,col] =find(A==1);
% indices=[row, col];
Iter=0;
fitness_MAX=length(col);
% Each row is an entry into the population
% Begin GA
XY=1:PopSize-Elitism;
fitness=zeros(size(population,1),1);
while(Iter<5000)
    Iter=Iter+1;
    % Evaluating fitness
    % Adjacent states having different color is good. Else its bad.
    fprintf('Iteration: %d\n',Iter)
    BestFitness=max(fitness)*100/fitness_MAX
    for i=1:size(population,1)
        fitness(i)=sum(population(i,row)~=population(i,col));
        
        if max(fitness)==fitness_MAX
            BestFitness=max(fitness)*100/fitness_MAX
            I=find(fitness==max(fitness));
            solution=population(I,:);
            score=BestFitness;
            h=figure(1);
            showmap(h,L,solution);
            return;
        end
        
    end
    
    % Sorting by fitness
    [~,I]=sort(fitness,1,'descend');
    population=population(I,:);
    
    
    % Performing Elitism
    newGen=[];
    newGen=cat(1,newGen,population(1,:),population(2,:));
    
    population(1,:)=[];
    population(2,:)=[];
    
    % Performing crossover
    [new]=tournament(population,tournamentSize,PopSize);
    
    [new]=mutate(new);
    
    newGen=cat(1,newGen,new);
    population=newGen;
    
    % Reinforcing Florida-Penn Constraint
    population(:,33)=1;
    population(:,40)=1;

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

% helper functions
%==========================================================================
function showmap(h,L,X)
% SHOWMAP Visualize the colored map.
%   h   Figure handle.
%   L   Label matrix representing an image of the map. Each pixel has an
%       integer value (0->lines, 1->background, and [2-51]->the 50 states).
%   X   An individual solution, encoded as a vector of integers to indicate
%       colors; that is, X(i) is the index into a color array for the ith
%       state. For example, if X(27)=3, then the 27th state (pixels for
%       which L=28) should take on the 3rd color.

clrs = [0.73 0.83 0.96;
        1 0.69 0.39;
        0.76 0.87 0.78;
        1 0.97 0.55;
        1 0.4 0.4];

figure(h); clf;
set(gcf,...
    'NumberTitle','off',...
    'Name','Map of the United States',...
    'Color',[1 1 1],...
    'MenuBar','none','Toolbar','none',...
    'Position',[300 200 786 570]);
axes(...
    'Color',[1 0.95 0.81],...
    'Position',[-0.001 -0.001 1.002 1.002]);
imshow(label2rgb(L,[1 1 1; clrs(X,:)],'k'));
end
