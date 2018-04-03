clear all;close all;clc
I=imread('W.bmp');
qiu=imread('qiu111.bmp');
%去背景
thresh = graythresh(I);     %自动确定二值化阈值
I2 = im2bw(I,thresh);   %对图像二值化
I3=find(I2==0);
qiur=qiu(:,:,1);
qiug=qiu(:,:,2);
qiub=qiu(:,:,3);
qiur(I3)=0; 
qiug(I3)=0; 
qiub(I3)=0;



%滤波
J=fspecial('average');
J1=filter2(J,qiur);
% figure,imshow(J1)
J2=filter2(J,qiug);
% figure,imshow(J2)
J3=filter2(J,qiub);
% figure,imshow(J3)
qiu2 = uint8(zeros(480,640));
qiu2(:,:,1) = J1;
qiu2(:,:,2) = J2;
qiu2(:,:,3) = J3;



%边界
D=zeros(480,640);
H=zeros(480,640);

for x =[1:479]
  for y =[1:639]
   D(x,y)=((J1(x+1,y)-J1(x,y))^2+(J2(x+1,y)-J2(x,y))^2+(J3(x+1,y)-J3(x,y))^2 )^0.5;
   
  end
end


%分辨颜色
RR=J1;
GG=J2;
BB=J3;
for x =[1:480]
  for y =[1:640]
   r=RR(x,y);
   g=GG(x,y);
   b=BB(x,y);
   M=[r,g,b];
   da=max(M);
   xiao=min(M);
   if da~=0
       if da==r&&xiao==b
           H(x,y)=1+(g-b)/(r-b);           
       end 
       if da==g&&xiao==b
           H(x,y)=3-(r-b)/(g-b);
       end  
       if da==g&&xiao==r
           H(x,y)=3+(b-r)/(g-r);
       end  
       if da==b&&xiao==r
           H(x,y)=5-(g-r)/(b-r);
       end  
       if da==b&&xiao==g
           H(x,y)=5+(r-g)/(b-g);
       end  
       if da==r&&xiao==g
           H(x,y)=7-(b-g)/(r-g);
       end  
       
   end
   
  %显示
  
   
%    if da ~=0
%        switch da
%            case RR(x,y)
%                RR(x,y)=70;
%            case GG(x,y)
%                GG(x,y)=70;
%            case BB(x,y)
%                BB(x,y)=70;
%        end
%        switch xiao
%            case RR(x,y)
%                RR(x,y)=0;
%            case GG(x,y)
%                GG(x,y)=0;
%            case BB(x,y)
%                BB(x,y)=0;
%        end
%        
%    end
      
  end
end

;
HH=round(H);

HH(find(HH==7))=1;




% HH=filter2(J,H);
% 
% HHH=round(HH);
% HHH(find(HHH==7))=1;


RRR=zeros(480,640);
GGG=zeros(480,640);
BBB=zeros(480,640);

for x =[1:480]
  for y =[1:640]
      switch HH(x,y)
          case 1 
              RRR(x,y)=255;
              GGG(x,y)=0;
              BBB(x,y)=0;
          case 2
              RRR(x,y)=255;
              GGG(x,y)=255;
              BBB(x,y)=0;
          case 3
              RRR(x,y)=0;
              GGG(x,y)=255;
              BBB(x,y)=0;
          case 4
              RRR(x,y)=0;
              GGG(x,y)=255;
              BBB(x,y)=255;
          case 5
              RRR(x,y)=0;
              GGG(x,y)=0;
              BBB(x,y)=255;
          case 6
              RRR(x,y)=255;
              GGG(x,y)=0;
              BBB(x,y)=255;          
      end
  end
end

qiu3 = uint8(zeros(480,640));
qiu3(:,:,1) = RRR;
qiu3(:,:,2) = GGG;
qiu3(:,:,3) = BBB;

RRR=filter2(J,RRR);
GGG=filter2(J,GGG);
BBB=filter2(J,BBB);
qiu4 = uint8(zeros(480,640));
qiu4(:,:,1) = RRR;
qiu4(:,:,2) = GGG;
qiu4(:,:,3) = BBB;


% 
% J4=filter2(J,D);
% JG=fspecial('sobel');
% J5=filter2(JG,J4);

% 
% tt=1;
% J4(find(J4>=tt))=255;
% J4(find(J4<=tt))=0;
% 
% 显示
figure,imshow(qiu3);
 figure,imshow(qiu2);
 figure,imshow(qiu4);
%imwrite(qiu2,'qiulubo.bmp');


% subplot(1,2,1);
% imshow(qiu2);
% title('原始图像');
% J=fspecial('average');
% J1=filter2(J,qiu3)/255;
% subplot(1,2,2);
% imshow(J1);
% title('3*3滤波');


