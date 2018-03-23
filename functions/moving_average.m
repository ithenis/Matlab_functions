function [y_smooth] = moving_average(x, y, span, which)
% syntax:   [y_smooth] = moving_average(x, y, span, which)
%           which can be 'smooth' or 'filter'.
%           span must be odd
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% Smooth the data using the loess and rloess methods with a span of 10%:
if strcmp(which,'smooth')
    y_smooth = smooth(x,y,span,'loess');  
    % 'rloess' = robust version of 'loess' that assigns lower weight to 
    %            outliers in the regression. The method assigns zero weight
    %            to data outside six mean absolute deviations.
    
elseif strcmp(which,'filter')
    y_smooth = filter(ones(1,span)/span,1,data); % equal weight
end