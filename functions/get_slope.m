function [ phi ] = get_slope(x, height)
%syntax:   [phi] = get_slope(x, height)
%calculates slope from height and x
%takes vertical vector inputs

if isvector(height) && numel(height)== numel(x)    
    height = height(:);
    x = x(:);
    dx = (x(end)-x(1))/(numel(x)-1);
    phi = diff(height)./diff(x);
    phi = interp1(x(2:end)-dx/2,phi,x,'pchip');
    phi = phi - mean(phi);
else
    numel(height)
    numel(x)
    disp('wrong type of inputs, need column vectors')
end

