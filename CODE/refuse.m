clear all;close all;clc
load HH.mat;
Q=zeros(480,640);
a=1;
H=HH;
for x =[1:640]
for y =[1:479]
  
      
      if H(y,x)~=0
          if H(y,x)==H(y+1,x)
             a=a+1;
              
          else
              Q(x,y)=a;
             a=1;
          
          end
      else
          continue
      end
      
      
      
  end
end











% 
% x=1;
% y=1;
% while x<=480&&y<=640
%     if HH(x,y)~=0
%     bb=0;
%     for i=1:100
%        if x+i>=480
%            bb=1;
%            break
%        end
%       if HH(x+i,y)~=HH(x,y)
%           break
%       end
%     end
%     Q(x,y)=i;
%         i=0;
% 
%     if bb==0&&x<=480
%   x=x+i+1;
%     
%     end
% if bb==1&&y<=640
%     bb=0;
%     y=y+1;
%     x=1;
% end
%    
%     end 
% end