function slope = diffnom(height,x)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   integrate slope data
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%   syntax:  height = intnom(slope,dx,remove_tilt)
%            slope is 1d data; remove_tilt is optional input
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
