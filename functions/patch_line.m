function [linie] = patch_line(linie)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

linie = linie(:);

xq = 1:numel(linie);
x = xq(~isnan(linie));
z = linie(~isnan(linie));
linie = interp1(x,z,xq);
end

