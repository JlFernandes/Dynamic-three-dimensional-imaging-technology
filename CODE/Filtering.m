%µÍÍ¨ÂË²¨
clear all;close all;clc

I=imread('R.bmp');
subplot(1,3,1);
imshow(I);
title('Ô­Ê¼Í¼Ïñ');
J=fspecial('average');
J1=filter2(J,I)/255;
subplot(1,3,2);
imshow(J1);
title('3*3ÂË²¨');
K=fspecial('average',9);
K1=filter2(K,I)/255;
subplot(1,3,3);
imshow(K1);
title('9*9ÂË²¨');




%307 404
