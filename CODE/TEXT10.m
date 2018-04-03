function []=text10()

clear all;close all;clc
load Corner_point.mat;
global M;
M=[];
% WX=[Corner_1(3,:),Corner_2(3,:),Corner_3(3,:),Corner_4(3,:),Corner_5(3,:),Corner_6(3,:)];
% WY=[Corner_1(4,:),Corner_2(4,:),Corner_3(4,:),Corner_4(4,:),Corner_5(4,:),Corner_6(4,:)];
WX=[Corner_2(3,:),Corner_3(3,:),Corner_4(3,:)];
WY=[Corner_2(4,:),Corner_3(4,:),Corner_4(4,:)];


% creatnum(Corner_1,10);
creatnum(Corner_2,20);
creatnum(Corner_3,30);
creatnum(Corner_4,40);
% creatnum(Corner_5,50);
% creatnum(Corner_6,60);

 AX=WX/M;
 AY=WY/M;
% j=1;
% u(j)=262;
% v(j)=193;
% z=20;
% 
%   mmm=[u(j)^3;v(j)^3;z^3;u(j)*v(j)*z;
%             (u(j)^2)*v(j);(v(j)^2)*u(j);(u(j)^2)*z;(z^2)*u(j);(z^2)*v(1,j);(v(j)^2)*z;
%             u(j)*v(j);u(j)*z;z*v(j);
%             u(j)^2;v(j)^2;z^2;
%             u(j);v(j);z;1];
%  xxx=AX*mmm;
%   yyy=AY*mmm;

 


end
function creatnum(B,z)
global M ;
u=B(1,:);
v=B(2,:);  
[~,m]=size(M);
j=1;
for i=m+1:m+16
    M(:,i)=[u(j)^3;v(j)^3;z^3;u(j)*v(j)*z;
            (u(j)^2)*v(j);(v(j)^2)*u(j);(u(j)^2)*z;(z^2)*u(j);(z^2)*v(1,j);(v(j)^2)*z;
            u(j)*v(j);u(j)*z;z*v(j);
            u(j)^2;v(j)^2;z^2;
            u(j);v(j);z;1];
    j=j+1;
end

end

