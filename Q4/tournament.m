function [newGen]=tournament(population)

% We need 498 offsprings. We perform the tournament selection for each
% parent
count=0;
newGen=[];
while (1)
    
    if count==size(population,1)
        return;
    end
    
    % Generating random indices K=10 for tournament
    I=randi(498,2,10);
    % Since the population is aranged in the order of fitness, the least
    % indices have max fitness
    
    I_parent=min(I,[],2);
    Mom=population(I_parent(1),:);
    Dad=population(I_parent(2),:);
    
    %Toss a coin of 10 sides to determine if the crossover is required
    thisToss=randi(10,1);
    if thisToss~=10
        
        [son,daughter]=crossover(Mom,Dad);
        count=count+2;
        newGen=cat(1,newGen,son,daughter);
    
    else
        newGen=cat(1,newGen,Mom,Dad);
        count=count+2;
    end
    

end
