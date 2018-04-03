clear all;close all;clc
load color_Code.mat
N = length(find(Code(:)~=0));
Code = Code(1:N);
Q(1)=1;
%% ЯћГ§жиТы
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
            Q(t)= j;
            Q(t+1) =k;
            B= [b(1) b(2) b(3)];
            C= [c(1) c(2) c(3)];
           t=t+2;
        end
    end
end
% n = p(1);
% a(n+1:n+2) = [];