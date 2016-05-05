function [newGen]=tournament(population,K,PopSize)

% We need 498 offsprings. We perform the tournament selection for each
% parent
count=0;
newGen=[];
while (1)
    
    if count==PopSize-2
        return;
    end
    
    % Generating random indices K=10 for tournament
    I=randi(PopSize-2,2,K);
    % Since the population is aranged in the order of fitness, the least
    % indices have max fitness
    
    I_parent=min(I,[],2);
    Mom=population(I_parent(1),:);
    Dad=population(I_parent(2),:);
    
    %Toss a coin of 10 sides to determine if the crossover is required
    thisToss=randi(10,1);
    if thisToss~=10
        
        %Choosing the indices for crossover; Toss a coin of 2 sides
        coinToss=randi(2,1,size(population,2));
        Index_for_crossover=find(coinToss==1);
     
        [son,daughter]=crossover(Mom,Dad,Index_for_crossover);
        count=count+2;
        newGen=cat(1,newGen,son,daughter);
    
    else
        newGen=cat(1,newGen,Mom,Dad);
        count=count+2;
    end
    

end
