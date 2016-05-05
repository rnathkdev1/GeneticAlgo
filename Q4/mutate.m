function [XMen]=mutate(genes)

xmin=-6;    ymin=-1.5;
xmax=3;     ymax=0;


tossCoin=randi(10,size(genes,1),size(genes,2));
[~,col]=find(tossCoin==1);
Xnum=sum(col==1);
Ynum=sum(col==2);

Xcol=col==1;
Ycol=col==2;


if ~isempty(col)
    randMutationX=xmin+rand(1,Xnum)*(xmax-xmin);
    randMutationY=ymin+rand(1,Ynum)*(ymax-ymin);
    genes(Xcol,1)=randMutationX;
    genes(Ycol,2)=randMutationY;
end

XMen=genes;

end