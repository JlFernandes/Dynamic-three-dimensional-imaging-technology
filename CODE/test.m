%% 10个像素单位的条纹宽度
clear all;clc;
R = imread('R.bmp');
G = imread('G.bmp');
B = imread('B.bmp');
% R =rgb2gray(R);
% G =rgb2gray(G);
% B =rgb2gray(B);

color_Map = uint8(zeros(480,640));
color_Map(:,:,1) = R;
color_Map(:,:,2) = G;
color_Map(:,:,3) = B;
figure,imshow(color_Map);

imwrite(color_Map,'tooth.bmp');
