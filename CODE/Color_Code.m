%% %%%%%%%%%%%%%% 基于RGBCMYK的彩色编码 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%三个颜色为一组组成无重复编码链
%码值  R G B  color
% 1:     1  0  0   R
% 2:      0 1 0   G
% 3:      0 0 1   B
% 4:      0 1 1   C
% 5:      1 0 1   M
% 6:      1 1 0   Y

%%  初始单元编码
clear all;close all;clc
n = 6;                               % 码值
Code = zeros(1,170);   %初始链长度
for i = 1:n
    Code(1) = i ;
    Code(2) = i+1;
    for j = 1:n
        Code(3) = j;
        if Code(3) ~= Code(2)
            Code(3) = j ;
        break;
        end
    end
  break;
end
%% 创建链表
m = length(Code);
j = 4;
for i = 1:m
    for k = 1:n
        Code(j) = k;
        Tag = 0;       %添加终止标志  
        if Code(j) ~= Code(j-1) 
            for q = 1:j-3
                Seq = [Code(q) Code(q+1) Code(q +2)];
                New = [Code(j -2) Code(j -1) Code(j)];
                if  isequal(Seq, New) ~= 1
                    Code(j) = k;
                    Tag = 1;                        
                    else if isequal(Seq, New) == 1 && Code(j) ~= n  
                        Tag = 2; 
                        break;        
                       else if  isequal(Seq, New) == 1 && Code(j) == n   %解决单个链内跳码
                                Code(j-1) = Code(j-1)+1;
                                 j = j-1;
                                Tag = 3; 
                                break;
                               end
                           end
               end
            end
         else if  Code(j) == n && Code(j-1) == n  %解决单个链间跳码
                  Code(j-2) = Code(j-2)+1;
                   j = j-2;
              end
        end
        if Tag ==1 
            break;
            else if Tag ==0 || Tag ==2
                    continue;
                else if Tag == 3
                     break;
                     else if Tag == 4
                             break;
                         end
                     end
                 end
        end
    end
    j = j+1;
end
N = length(find(Code(:)~=0));
Code = Code(1:N);

%% 消除重码
t=1;
for j = 1:(N-2)
    b(1) = Code(j);
    b(2) = Code(j+1);
    b(3) = Code(j+2);
    for k = 1:(N-2)
        c(1) = Code(k);
        c(2) =Code(k+1);
        c(3) =Code(k+2);
        if isequal(b, c) == 1 && j ~= k
            p(t)= j;
            p(t+1) =k;
            B= [b(1) b(2) b(3)];
            C= [c(1) c(2) c(3)];
           t=t+2;
        end
    end
end
n = p(1); 
Code(n+1:n+2) = [];
save Color_Code.mat Code;

%% 彩色作图
Code = uint8(Code);
m = length(Code);
for i =1:m
    if Code(i) == 1 
        R(i) = 255;
        G(i) = 0;
        B(i) = 0;
    else if Code(i) == 2 
             R(i) = 0;
             G(i) = 255;
             B(i) = 0;
        else if Code(i) == 3 
                R(i) = 0;
                G(i) = 0;
                B(i) = 255;
            else if Code(i) == 4 
                    R(i) = 0;
                    G(i) = 255;
                    B(i) = 255;
                else if Code(i) == 5 
                        R(i) = 255;
                        G(i) = 0;
                        B(i) = 255;
                    else if Code(i) == 6 
                            R(i) = 255;
                            G(i) = 255;
                            B(i) = 0;
                        end
                    end
                end
            end
        end
    end   
end
% 设置684*608的像素区域
RR = kron(R, ones(684,5));   %5个像素为一个条纹宽度
GG = kron(G, ones(684,5));
BB = kron(B, ones(684,5));
RRR = RR(:,1:608);
GGG = GG(:,1:608);
BBB = BB(:,1:608);
%R G B
figure,imshow(RRR);
imwrite(RRR,'R.bmp');
figure,imshow(GGG);
imwrite(GGG,'G.bmp');
figure,imshow(BBB);
imwrite(BBB,'B.bmp');
%White
White = uint8(zeros(684,608));
White(:,:) = 255;
figure,imshow(White);
imwrite(White,'White.bmp');
%display
color_Map = uint8(zeros(684,608));
color_Map(:,:,1) = RRR;
color_Map(:,:,2) = GGG;
color_Map(:,:,3) = BBB;
figure,imshow(color_Map);
imwrite(color_Map,'color_Map.bmp');




    




