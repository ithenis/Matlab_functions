function output = fitfiz(data,x,yc,ny)

height = squeeze(mean(data(round(yc-ny/2):round(yc+ny/2),:),1));
 
x = x(yc,:);
dx = x(2)-x(1);

slope = diff(height)./diff(x);
output = fitnom(x(1:end-1)',slope','cylinder',[]);

output.height = height;
output.x = x;
output.slope = slope;