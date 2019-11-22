function residual_y = remove_poly(x,y,deg)
% remove 1d polynomial curve from 1d data
% syntax: residual_y = remove_poly(x,y,deg)

[fitcoeffs,~,mu] = polyfit(x, y, deg);
fitted_poly = polyval(fitcoeffs, x,[],mu);
residual_y = y - fitted_poly;
