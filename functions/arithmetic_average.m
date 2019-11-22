function [y_smooth] = arithmetic_average(y, span)

s1 = size(y, 1);    
m  = s1 - mod(s1, span);
yblock  = reshape(y(1:m), span, []);     % Reshape x to a [n, m/n] matrix
y_smooth = transpose(sum(yblock, 1) / span);  