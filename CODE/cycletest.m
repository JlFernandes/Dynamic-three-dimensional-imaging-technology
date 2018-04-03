
function [] =qiushiyan()
clear all;close all;clc

I=imread('W.bmp');
tu=imread('tu.bmp');
D=zeros(480,640);
DD=zeros(480,640);
H=zeros(480,640);
M=zeros(480,640);
N=zeros(480,640);
NN=zeros(480,640);


%% 去背景

% thresh = graythresh(I);%自动确定二值化阈值
thresh=0.1;
I2 = im2bw(I,thresh);   %对图像二值化
I3=find(I2==0);
tur=tu(:,:,1);
tug=tu(:,:,2);
tub=tu(:,:,3);
tur(I3)=0; 
tug(I3)=0; 
tub(I3)=0;

%% 滤波
% J=fspecial('average');
J=[0.1,0.1,0.1;0.1,0.2,0.1;0.1,0.1,0.1];
tur=filter2(J,tur);
% figure,imshow(J1)
tug=filter2(J,tug);
% figure,imshow(J2)
tub=filter2(J,tub);
% figure,imshow(J3)
tu2 = uint8(zeros(480,640));
tu2(:,:,1) = tur;
tu2(:,:,2) = tug;
tu2(:,:,3) = tub;

%% 颜色距离

for y =1:480
  for x =1:639
   D(y,x)=((tur(y,x+1)-tur(y,x))^2+(tug(y,x+1)-tug(y,x))^2+(tub(y,x+1)-tub(y,x))^2 )^0.5;
   
  end
end
D=filter2(J,D);

%% 最大值分割
for y =1:480
  for x =2:639
   if D(y,x)~=0&&D(y,x)>=D(y,x-1)&&D(y,x)>=D(y,x+1)
       DD(y,x)=255;
       
   end
   
  end
end

%% 颜色分配
for x =1:480
  for y =1:640
   r=tur(x,y);
   g=tug(x,y);
   b=tub(x,y);
H(x,y)=color1(r,g,b);
  end
end
H=round(H);
H(find(H==7))=1;
H(find(DD==255))=10;

%% 矫正
x1=0;
d=0;
for y =1:480
      for x =1:640
     
      if H(y,x)==10
           if x1==0
               x1=x;
          continue
           end
          d=(x1+x)/2;
          d=round(d);
          
          H(y,x1:x)=H(y,d);
          x1=x;
          if x==640
              x1=0;
          end 
      end   
      end
end

%% 分界M
for y =1:480
  for x =2:640
      if H(y,x)~=H(y,x-1)&&H(y,x)~=0
          M(y,x)=H(y,x);
      end
      
  end
end
%转码M
% for y =1:480
%   for x =1:640
%       switch M(y,x)
%           case 2
%               M(y,x)=6;
%           case 3
%               M(y,x)=2;
%           case 5
%               M(y,x)=3;
%           case 6
%               M(y,x)=5;         
%       end    
%   end
% end

load('Color_Code.mat');
%% 译码
c1=0;
c2=0;
c3=0;
for y =1:480
  for x =1:640
      if M(y,x)~=0
          c1=c2;
          c2=c3;
          c3=M(y,x);
          if c1==0||c2==0
              continue
          end
          for i=3:148
              if c1==Code(i-2)&&c2==Code(i-1)&&c3==Code(i)
                  N(y,x)=i;
              end
          end
          if x==640
              c1=0;
              c2=0;
              c3=0;
          end  
      end
  end
end

%% 标定
% N(find(N>=80))=0;
%  set=N;
%  save ZHONG set;

%% 绘图
i=1;
load('C:\Users\hp\Desktop\bishe\新建文件夹\实验数据2016.1.11\白板\zhong\ZHONG.mat');
% global X Y Z ;

for y =1:10:480
  for x =1:640
      if N(y,x)~=0
          for xzhong=1:640
              if N(y,x)==ZHONG(y,xzhong)
                  X(i)=xzhong;
                  Y(i)=y;
                  Z(i)=1*(x-xzhong);
                  i=i+1;
              end
          end
      end
  end
end

%qiu x 100 500 y 100 500 z 50 120
%tou x 0 650 y 0 500 z -60 80
%YA X 200 650 Y 0 500 Z -100 10
%  Z(find(Z>10))=-50;
%  Z(find(Z<-100))=-50;
% Z=filter2(J,Z);
% 
% % 
% [xx,yy]=meshgrid(	200:10:650,1:10:500);  %生成网格点
% zz=griddata(X,Y,Z,xx,yy);%你的数据得插值成网格型数据。
% zz=filter2(J,zz);
% 
% surf(xx,yy,zz);
% shading interp ; 
% colormap(gray);



%% 颜色分配
RRR=zeros(480,640);
GGG=zeros(480,640);
BBB=zeros(480,640);
for x =1:480
  for y =1:640
      switch H(x,y)
          case 1   %R
              RRR(x,y)=255;
              GGG(x,y)=0;
              BBB(x,y)=0;
          case 2   %Y
              RRR(x,y)=255;
              GGG(x,y)=255;
              BBB(x,y)=0;
          case 3   %G
              RRR(x,y)=0;
              GGG(x,y)=255;
              BBB(x,y)=0;
          case 4  %C
              RRR(x,y)=0;
              GGG(x,y)=255;
              BBB(x,y)=255;
          case 5   %B
              RRR(x,y)=0;
              GGG(x,y)=0;
              BBB(x,y)=255;
          case 6   %M
              RRR(x,y)=255;
              GGG(x,y)=0;
              BBB(x,y)=255;   
           case 10
              RRR(x,y)=0;
              GGG(x,y)=0;
              BBB(x,y)=0; 
      end
  end
end

tu3 = uint8(zeros(480,640));
tu3(:,:,1) = RRR;
tu3(:,:,2) = GGG;
tu3(:,:,3) = BBB;



% 显示
 figure,imshow(tu);
figure,imshow(tu2);
  figure,imshow(DD);
 figure,imshow(tu3);
 

end
  


function result= color1(r,g,b)%分辨颜色
 M=[r,g,b];
   da=max(M);
   xiao=min(M);
   result=0;
   if da~=0
       if da==r&&xiao==b
           result=1+(g-b)/(r-b);           
       end 
       if da==g&&xiao==b
           result=3-(r-b)/(g-b);
       end  
       if da==g&&xiao==r
           result=3+(b-r)/(g-r);
       end  
       if da==b&&xiao==r
          result=5-(g-r)/(b-r);
       end  
       if da==b&&xiao==g
           result=5+(r-g)/(b-g);
       end  
       if da==r&&xiao==g
          result=7-(b-g)/(r-g);
       end  
       
   end
end



