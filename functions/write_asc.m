function write_asc(fname,data)

format long g

% save data 
dlmwrite(fname, data, 'delimiter', '\t','newline', 'pc','precision','%.9f');

% writeTXT('I09_SM6B_height_error_specified_ellipse',[repolished.active_x repolished.height_err*10^9]);
