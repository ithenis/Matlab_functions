function slope = diffnom(x, height)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   differentiate height data
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   syntax:  slope = diffnom(x, height)
%            height and x are 1d data; 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


if ~isvector(height)
    disp('check ''height'' input: it has to be 1D')
    slope = [];
    return
end
if ~isvector(x)
    disp('check ''x'' input: it has to be 1D')
    slope = [];
    return
end

height = height(:);
x = x(:);

slope = diff(height)./diff(x);

dx = (x(end)-x(1))/(numel(x)-1);
xx = x(2:end)-dx/2;

slope = interp1(xx, slope, x, 'spline');
