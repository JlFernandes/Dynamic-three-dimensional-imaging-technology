clear all;close all;clc
R = imread('R.bmp');
G = imread('G.bmp');
B = imread('B.bmp');
W = imread('W.bmp');

too = imread('tu.bmp');

r1 = too(:,:,1);
g1 = too(:,:,2);
b1 = too(:,:,3);



tt=40;
r1(find(r1>=tt))=255;
r1(find(r1<=tt))=0;
g1(find(g1>=tt))=255;
g1(find(g1<=tt))=0;
b1(find(b1>=tt))=255;
b1(find(b1<=tt))=0;

QQ = uint8(zeros(480,640));
QQ(:,:,1) = r1;
QQ(:,:,2) = g1;
QQ(:,:,3) = b1;
figure,imshow(QQ);
figure,imshow(too);



%figure,imshow(r1);

%Tr = [255,0;0,255];
%Tg = [0,0;255,0];
%Tb = [255,255;0,255];
%figure,imshow(Tb);

%color_Map = uint8(zeros(2,2));
%color_Map(:,:,1) = Tr;
%color_Map(:,:,2) = Tg;
%color_Map(:,:,3) = Tb;
%figure,imshow(color_Map);