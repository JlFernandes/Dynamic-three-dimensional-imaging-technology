function []=text8()
 clear all;close all;clc
global M ;
global W;
global A;
load 0;
load 10;
load 20;
load 30;
load 40;
load 50;
load 60;

% load('C:\Users\hp\Desktop\bishe\±œ…Ë4.1\0mm\Color_Code.mat');
% A=zeros(1,10);
for i=20:100
M=[];
W=[];
% B0=findcode(N0,i);
% B1=findcode(N10,i);
B2=findcode(N20,i);
B3=findcode(N30,i);
B4=findcode(N40,i);
% B5=findcode(N50,i);
% B6=findcode(N60,i);

% creatnum(B0,0);
% creatnum(B1,10);
creatnum(B2,20);
creatnum(B3,30);
creatnum(B4,40);
% creatnum(B5,50);
% creatnum(B6,50);
[~,ww]=size(W);
[~,mm]=size(W);

if mm~=ww
 A(i,:)=[0,0,0,0,0,0,0,0,0,0];
else
 A(i,:)=W/M;
end
end
end

function result=findcode(N,i)
[v,u]=find(N==i);
result=[v,u];
end


function result =findnum(x)
% J1=fspecial('average');
% x=filter(J1,x);

[~,a]=size(x);
j=1;
y=0;
for i=1:10:a
    
    y(1,j)=x(1,i);
    j=j+1;
end

result=y;
end

function creatnum(B,a)

global M ;
global W;
u=B(:,2)';
v=B(:,1)';  
u=findnum(u);
v=findnum(v);
[~,m11]=size(u);
[~,m22]=size(v);
m1=min(m11,m22);

[~,m2]=size(M);
[~,m3]=size(W);

j=1;
for i=m2+1:m2+m1
    M(:,i)=[u(j)^3;v(j)^3;(u(j)^2)*v(j);(v(j)^2)*u(j);u(j)*v(j);u(j)^2;v(j)^2;u(j);v(j);1];
    j=j+1;
end
W(m3+1:m3+m1)=a;

end

