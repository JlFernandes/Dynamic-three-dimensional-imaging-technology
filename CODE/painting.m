data=[
 1 1 5.14
 1 2 9.56
 1 3 8.66
 2 1 12.55
 2 2 10.51
 2 3 2.7
 3 1 22.03
 3 2 22.97
 3 3 32.94
 4 2 55.58
 4 3 24.55
]; %第一列为x,第二列为y，第三列为z

[xx,yy]=meshgrid(1:4,1:3);  %生成网格点
zz=griddata(data(:,1),data(:,2),data(:,3),xx,yy,'v4');%你的数据得插值成网格型数据。
surf(xx,yy,zz);
shading interp ;