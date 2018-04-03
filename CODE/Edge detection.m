clear all;close all;clc

I=imread('R.bmp');
subplot(2,2,1);
imshow(I);
title('原始图像');
subplot(2,2,2);
I1=edge(I,'sobel');
imshow(I1);
title('Sober方法提取的边缘');
subplot(2,2,3);
imshow(I);
title('原始图像');
subplot(2,2,4);
I2=edge(I,'log');
imshow(I2);
title('L-P方法提取的边缘');
