function [XMen]=mutate(genes)


tossCoin=randi(10,size(genes,1),size(genes,2));
I=find(tossCoin==10);
randMutation=randi(4,size(I,1),1);
genes(I)=randMutation;
XMen=genes;

end


