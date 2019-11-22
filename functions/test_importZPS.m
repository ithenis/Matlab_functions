
clear all
close all
clc



[fname,pathname] = uigetfile([ '*.csv'],'Select data file','MultiSelect','on');

if iscell(fname)
    fname = sort(fname);
elseif fname == 0    
    disp('user abort')
    fname = '';
    cale = '';
    return
else
    fname = {fname};
end
ZPSdata = [];
for kk = 1:numel(fname)
    
    filename = [pathname fname{kk}];
    output = importZPSfileLB(filename);
    ZPSdata = [ZPSdata; output.ZPSdata];
    
    info{2*kk-1} = output.info{1};
    info{2*kk} = output.info{2};
    
end
info = info';
headers = output.headers;
clear output




