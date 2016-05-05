clc; clear;
%% Declaring Parameters
[X,Y]=meshgrid(-6:0.001:3,-1.5:0.001:0);
xmin=-6;    ymin=-1.5;
xmax=3;     ymax=0;
popSize=500;
Iter=0;
ElitePercent=0.04;


%% Starting the GA

populationX=xmin+rand(1,popSize)*(xmax-xmin);
populationY=ymin+rand(1,popSize)*(ymax-ymin);

population=[populationX' populationY'];

while(1)
    Iter=Iter+1;
    fprintf('Iteration: %d\n',Iter);
    
    % Evaluating fitness function
    % Here fitness function is the cost function itself
    
    fitness=costFunction(population);
    max(fitness)
    % Sorting population by fitness
    
    [~,I]=sort(fitness,1,'descend');
    
    if Iter==500
        optimal=population(1,:);
        break;
    end
    
    population=population(I,:);
    
    if round(10000*population(1,1))/10000==-5.0171
        Iter
        optimal=population(1,:);
        break;
    end
    
    
    % Performing Elitism
    newGen=[];
    N_elitism=floor(ElitePercent*500);
    Elites= population(1:N_elitism,:);
    newGen=cat(1,newGen,Elites);
    
    population(1:N_elitism,:)=[];
    
    % Performing crossover
%     [new]=tournament(population);
    
    % Performing mutation
    [new]=mutate(population);
    
    newGen=cat(1,newGen,new);
    population=newGen;
  
end

disp('The optimal point for this problem is: ');
optimal
