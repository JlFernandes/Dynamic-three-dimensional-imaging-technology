function [] =findcolor()
clear all;close all;clc
IMG=imread('0.bmp');
IMGr=IMG(:,:,1);
IMGg=IMG(:,:,2);
IMGb=IMG(:,:,3);
%距离矩阵
D=zeros(480,640);
%译码矩阵
N=zeros(480,640);
%探测距离
z=10;
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
for y =1:z:480
    for x =1:639
        D(y,x)=(IMGr(y,x+1)-IMGr(y,x))^2+(IMGg(y,x+1)-IMGg(y,x))^2+(IMGb(y,x+1)-IMGb(y,x))^2 ;
    end
end
D=filter2(J,D);
D=filter2(J2,D);
%% 展示 z=10时
 showchance(D,IMGr,IMGg,IMGb);
%% 分界M译码
load('C:\Users\hp\Desktop\bishe\图\标定\Color_Code.mat');
for y =1:z:480
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
            for i=3:36  %使用范围
                if c1==Code(i-2)&&c2==Code(i-1)&&c3==Code(i)
                    N(y,x)=i;
                end
            end
        end
    end
end
N=jiaozheng(N);

%% 标定
load('C:\Users\hp\Desktop\bishe\图\标定\NUM40.mat');
%%
i=1;
for y =1:z:480
  for x =1:640
      if N(y,x)~=0
          for xz=1:640
              if N(y,x)==N40(y,xz)  
                  if (x-xz)>=-20&&(x-xz)<=50
                      X(i)=xz;
                      Y(i)=y;
                      Z(i)=(x-xz);
                      i=i+1;
                  end
              end
          end
      end
  end
end

[xx,yy]=meshgrid(1:z:600,1:z:700);  %生成网格点
zz=griddata(X,Y,Z,xx,yy);%你的数据得插值成网格型数据。
 zz=filter2(J1,zz);
figure,surf(xx,yy,zz);
shading interp ;
colormap(gray);

figure,scatter3(X,Y,Z);

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
    elseif result<=2.7&&result>=1.9
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
