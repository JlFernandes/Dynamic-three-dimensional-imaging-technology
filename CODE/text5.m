function []=text5
load NUM;
NN=zeros(480,640);
 NN=N;
 for i=1:5
NN=jiaozheng(NN);
 end
 
end

function result=jiaozheng(N)
c=1;
for y=1:480
    for x=1:640
        if N(y,x)~=0
            if N(y,x)<=N(y,c)
                N(y,c)=0;
%                 continue;
            end            
             c=x;
        end
        if x==640;
            c=1;
        end
    end
end
result=N;
end
