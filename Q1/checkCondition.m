function [condition,solution]=checkCondition(population)
condition=0;
solution=[];
for i=1:size(population,1)
    
    
    count1=sum(population(i,:)==1);
    count2=sum(population(i,:)==2);
    count3=sum(population(i,:)==3);
    count4=sum(population(i,:)==4);
    
    countMat=sort([count1 count2 count3 count4]);
    
    if isequal(countMat,[12 12 13 13])
        condition=1;
        solution=population(i,:);
        return;
    end
end

end