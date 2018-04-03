load('C:\Users\hp\Desktop\bishe\毕设4.1\数据\NUM35.mat');
load('C:\Users\hp\Desktop\bishe\毕设4.1\数据\A.mat')
load('C:\Users\hp\Desktop\bishe\毕设4.1\球\QIU.mat')

% global X Y Z ;
%%
i=1;
 J=fspecial('average');
for y =1:10:480
  for x =1:640
      if N(y,x)~=0
          a=A(N(y,x),:);
          for xzhong=1:640
              if N(y,x)==N35(y,xzhong)
                  X(i)=xzhong;
                  Y(i)=y;
  %   M(:,i)=[u(j)^3;v(j)^3;(u(j)^2)*v(1,j);(v(j)^2)*u(j);u(j)*v(j);u(j)^2;v(j)^2;u(j);v(j);1];
                  Z(i)=a(1)*X(i)^3+a(2)*Y(i)^3+a(3)*(X(i)^2)*Y(1,i)+a(4)*(X(i)^2)*Y(i)+a(5)*X(i)*Y(i)+a(6)*X(i)^2+a(7)*Y(i)^2+a(8)*X(i)+a(9)*Y(i)+a(10);
                  X(i)=xzhong* 0.14493;
                  Y(i)=y* 0.14493;
                  i=i+1;
              end
          end
      end
  end
end
  X(find(X>70))=40;
  X(find(X<40))=40;
  Y(find(Y>70))=40;
  Y(find(Y<40))=40;
  Z(find(Z>35))=25;
  Z(find(Z<25))=25;
  Z=Z*10;
  


[xx,yy]=meshgrid(	40:1:70,40:1:70);  %生成网格点
zz=griddata(X,Y,Z,xx,yy,'linear' );%你的数据得插值成网格型数据。
zz=filter2(J,zz);

surf(xx,yy,zz);
shading interp ; 
colormap(gray);