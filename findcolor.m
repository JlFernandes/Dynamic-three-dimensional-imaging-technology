function [] =findcolor()
clear all;close all;clc

[xx,yy]=meshgrid(0 :160 ,0: 160);  %生成网格点

zz=ones(161,161)*9;
h=surf(zz);
set(gca,'nextplot','replacechildren');
axis([0 160 0 160 -20 60]);
shading interp ;
colormap(gray); 
view([0,0,1]);
load('C:\Users\hp\Desktop\bishe\图1\标定\A.mat');
load('C:\Users\hp\Desktop\bishe\图1\标定\AX.mat');
load('C:\Users\hp\Desktop\bishe\图1\标定\AY.mat');
for img =100:10:990
IMGG = {imread(['acA640-750uc__21815743__20160413_164226388_0',num2str(img),'.bmp'])};
IMG=IMGG{1};
% IMG=imread('acA640-750uc__21815743__20160413_165347952_0249.bmp');
% figure,imshow(IMG);
IMGr=IMG(:,:,1);
IMGg=IMG(:,:,2);
IMGb=IMG(:,:,3);
%距离矩阵
D=zeros(480,640);
%译码矩阵
N=zeros(480,640);
%探测距离
z1=10;
%使用
mmm=25:80;
%% 图片处理
J=fspecial('average',5);
J1=fspecial('average');
%圆形滤波器
J2=fspecial('disk');
%滤波
IMGr=filter2(J,IMGr);
IMGg=filter2(J,IMGg);
IMGb=filter2(J,IMGb);
%去背景
I=find(IMGr<=40&IMGg<=40&IMGb<=40);
IMGr(I)=0;
IMGg(I)=0;
IMGb(I)=0;
%% 颜色距离矩阵
for y =1:z1:480
    for x =1:639
        D(y,x)=(IMGr(y,x+1)-IMGr(y,x))^2+(IMGg(y,x+1)-IMGg(y,x))^2+(IMGb(y,x+1)-IMGb(y,x))^2 ;
    end
end
D=filter2(J,D);
%   D=filter2(J2,D);
%% 展示 z=10时
%    showchance(D,IMGr,IMGg,IMGb);
%% 分界M译码
load('C:\Users\hp\Desktop\bishe\图\标定\Color_Code.mat');
for y =1:z1:480
    x1=1;
    c1=0;
    c2=0;
    c3=0;
    for x =2:640
        if  D(y,x)~=0&&D(y,x)>=D(y,x-1)&&D(y,x)>=D(y,x+1)
            if x1==1
                x1=x;
                continue;
            end
            d=round((x1+x)/2);
            x1=x;               
            c1=c2;
            c2=c3;
            c3=colorset(IMGr(y,d),IMGg(y,d),IMGb(y,d));
            if c2==0
                continue
            end
            for i=mmm  %使用范围
                if c1==Code(i-2)&&c2==Code(i-1)&&c3==Code(i)
                    N(y,x)=i;
                end
            end
        end
    end
end
N=jiaozheng(N);

%% 标定
% load('C:\Users\hp\Desktop\bishe\图1\标定\1\N0.mat');

i=1;
for y =1:z1:480
  for x =1:640
      if N(y,x)~=0&&25<=N(y,x)&&N(y,x)<=80
          a=A(N(y,x),:);
          ZZ=a*[x^3;y^3;(x^2)*y;(y^2)*x;x*y;x^2;y^2;x;y;1];
          z=ZZ;
          XX=AX*[x^3;y^3;z^3;x*y*z;(x^2)*y;(y^2)*x;(x^2)*z;(z^2)*x;(z^2)*y;(y^2)*z;x*y;x*z;z*y;x^2;y^2;z^2;x;y;z;1];
          YY=AY*[x^3;y^3;z^3;x*y*z;(x^2)*y;(y^2)*x;(x^2)*z;(z^2)*x;(z^2)*y;(y^2)*z;x*y;x*z;z*y;x^2;y^2;z^2;x;y;z;1];
          if -20<=XX&&XX<=140&&-5<=YY&&YY<=140&&-10<=ZZ&&ZZ<=70
      
              X(i)=XX+20;
              Y(i)=YY+20;
              Z(i)=ZZ;
          i=i+1;
          end
      end
  end
end 


% figure,scatter3(X,Y,Z);'nearest'
% axis([-20 140 -20 140 0 48])
J3=fspecial('average',8);
% [xx,yy]=meshgrid(-20 :10:140 ,-20:10: 140);  %生成网格点
zz=griddata(X,Y,Z,xx,yy);%你的数据得插值成网格型数据。

zz(isnan(zz))=10;
zz(zz>-15&zz<10)=10;

zz=filter2(J3,zz);

set(h,'Zdata',zz) ;
 
% surf(xx,yy,zz);
% shading interp ;
% colormap(gray); 
% view([0,0,1]);

saveas(h,['C:\Users\hp\Desktop\bishe\888\gift1\',num2str(img) '.jpg'])

% M(:,frame)= getframe;
% frame=frame+1;
end
% movie(M);
end

function result= colorset(r,g,b)%分辨颜色
M=[r,g,b];
da=max(M);
xiao=min(M);
result=0;
if da~=0
    if da==r&&xiao==b
        result=1+(g-b)/(r-b);
    elseif da==g&&xiao==b
        result=3-(r-b)/(g-b);
    elseif da==g&&xiao==r
        result=3+(b-r)/(g-r);
    elseif da==b&&xiao==r
        result=5-(g-r)/(b-r);
    elseif da==b&&xiao==g
        result=5+(r-g)/(b-g);
    elseif da==r&&xiao==g
        result=7-(b-g)/(r-g);
    end
    %特殊阀值设定
    if result<1.9&&result>1
        result=1;
    elseif result<=2.5&&result>=1.9
        result=2;
    elseif result<6.3&&result>5.3
        result=6;
    elseif result>=6.3
        result=1;
    end
    result=round(result);
end
end
function showColor(H)%显示图像
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
IMG = uint8(zeros(480,640));
IMG(:,:,1) = RRR;
IMG(:,:,2) = GGG;
IMG(:,:,3) = BBB;

figure,imshow(IMG);
end
function result=jiaozheng(N)
for y=1:480
    c=1;
    for x=1:640
        if N(y,x)~=0
            if N(y,x)<=N(y,c)
                N(y,c)=0;
            end
            c=x;
        end
        
    end
end
for y=1:480
    for x=1:640
        if N(y,x)~=0
        NN=N(y,x);
        for xx=x+1:640
            if N(y,xx)==NN
                N(y,x)=0;
                N(y,xx)=0;
            end
        end
        end
    end
end
result=N;
end%矫正码
function showchance(D,IMGr,IMGg,IMGb)
IMG = uint8(zeros(480,640));
IMG(:,:,1) = IMGr;
IMG(:,:,2) = IMGg;
IMG(:,:,3) = IMGb;
figure,imshow(IMG);

DD=zeros(480,640);
H=zeros(480,640);
% 最大值分割 演示效果 边界图
for y =1:480
    for x =2:639
        if D(y,x)~=0&&D(y,x)>=D(y,x-1)&&D(y,x)>=D(y,x+1)
            DD(y,x)=255;
        end
    end
end
figure,imshow(DD);
% 颜色分配 演示效果 条纹图1
for x =1:480
    for y =1:640
        r=IMGr(x,y);
        g=IMGg(x,y);
        b=IMGb(x,y);
        H(x,y)=colorset(r,g,b);
    end
end
showColor(H);
% 矫正图 完成图演示 条纹图2
for y =1:480
    x1=1;
    for x =2:640
        if  D(y,x)~=0&&D(y,x)>=D(y,x-1)&&D(y,x)>=D(y,x+1)
            if x1==1
                x1=x;
                continue;
            end
            d=round((x1+x)/2);
            r=IMGr(y,d);
            g=IMGg(y,d);
            b=IMGb(y,d);
            H(y,d)=colorset(r,g,b);
            H(y,x1:x)=H(y,d);
            x1=x;
        end
    end
end
showColor(H);
end%展示过程
