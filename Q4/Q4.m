clc; clear;
%% Declaring Parameters
[X,Y]=meshgrid(-6:0.001:3,-1.5:0.001:0);
[X_toplot,Y_toplot]=meshgrid(-6:0.1:3,-1.5:0.1:0);
xmin=-6;    ymin=-1.5;
xmax=3;     ymax=0;
popSize=500;
Iter=0;
ElitePercent=0.04;

%% This part is to determine the critical points
f=sin(X).*sin(2*Y) + 0.3*X;
f_toplot=sin(X_toplot).*sin(2*Y_toplot) + 0.3*X_toplot;
GLOB_MAX=round(max(max(f))*1000)/1000;
GLOB_MIN=round(1000*min(min(f)))/1000;

[grX, grY]=gradient(f);


I=abs(grX)<5e-6;
J=abs(grY)<5e-6;

Min=I.*J;

[row,col]=find(Min==1);
for i=1:length(row)
    X_plot_gr(i)=X(row(i),col(i));
    Y_plot_gr(i)=Y(row(i),col(i));
    
end

coord=[X_plot_gr', Y_plot_gr'];
[~,centroid]=kmeans(coord,5);


L=length(centroid);
f_stat_points=zeros(L,1);

syms x y;

F=sin(x).*sin(2*y) + 0.3*x;

Fx=diff(F,x);
Fy=diff(F,y);
Fxx=diff(Fx,x);
Fyy=diff(Fy,y);
Fxy=diff(Fx,y);



for i=1:L
    x=centroid(i,1);
    y=centroid(i,2);
    thisPoint=[x,y]
    
    f_stat_points(i)=round(1000*(sin(x).*sin(2*y) + 0.3*x))/1000;
    if f_stat_points(i)==GLOB_MIN
        disp('This is Global Min');
    elseif f_stat_points(i)==GLOB_MAX
        disp('This is Global Max');
        
    else
        
        Fxx_=eval(Fxx);
        Fyy_=eval(Fyy);
        Fxy_=eval(Fxy);
        
        H=[Fxx_ Fxy_; Fxy_ Fyy_];
        D=det(H);
        
        if Fxx_>0 && D>0
            disp('Local Min');
        elseif Fxx_<0 && D>0
            disp('Local Max');
        elseif D<0
            disp('Saddle Point');
        else disp ('Inconclusive');
        end
        
    end
        
end

%% Plotting the data

figure;
surf(X_toplot,Y_toplot,f_toplot);
colormap summer;

% figure;
% scatter(X_plot_gr,Y_plot_gr)


%% Starting the GA

populationX=xmin+rand(1,popSize)*(xmax-xmin);
populationY=ymin+rand(1,popSize)*(ymax-ymin);

population=[populationX' populationY'];
disp('Beginning GA.....');
while(1)
    
    Iter=Iter+1;
    norm(std(population'),2)
%     fprintf('Iteration: %d\n',Iter);
    
    % Evaluating fitness function
    % Here fitness function is the cost function itself
    
    fitness=costFunction(population);
%     max(fitness)
    % Sorting population by fitness
    
    [~,I]=sort(fitness,1,'descend');
    
    if Iter==500
        optimal=population(1,:);
        break;
    end
    
    population=population(I,:);
    
%     if round(10000*population(1,1))/10000==-5.0171
%         Iter
%         optimal=population(1,:);
%         break;
%     end
    
    % Performing Elitism
    newGen=[];
    N_elitism=floor(ElitePercent*500);
    Elites= population(1:N_elitism,:);
    newGen=cat(1,newGen,Elites);
    
    population(1:N_elitism,:)=[];
    
    % Performing crossover
    [new]=tournament(population);
    
    % Performing mutation
    [new]=mutate(new);
    
    newGen=cat(1,newGen,new);
    population=newGen;
  
end

disp('The optimal point for this problem is: ');
optimal
