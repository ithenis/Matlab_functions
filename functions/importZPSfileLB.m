function output = importZPSfileLB(filename)
% syntax: ZPSdata = importZPSfile(filename)

% the function imports a longburst zygo zps file. it doesn't need to know the
% number of columns (channels) or datapoints

% filename = 'S:\Science\Optics\Metrology Lab\Metrology Tests\_One-off projects\_ZPS\_Zygo ZPS tests (June 2019)\datafiles\longburst\ZPSframe_OML_bimorph_ontheNOM_nomless_16ch_p1steps_updown_LongBurst_190729-120738_1.csv';
%% Initialize variables.
delimiter = ',';
startRow = 9;
endRow = inf;

[fname,pathname] = uigetfile([ '*.csv'],'Select data file','MultiSelect','on');

if iscell(fname)
%     if numel(fname)>9
%        for kk = 1: numel(fname)
%            if strcmp(fname{kk}(end - 5),'_')
%                fname{kk} = [fname{kk}(1:end-5) '0' fname{kk}(end-4:end)];               
%            end
%        end
%     end
    fname = sort(fname);
    fname'
elseif fname == 0
    disp('user abort')
    fname = '';
    cale = '';
    return
else
    fname = {fname};
end
output.ZPSdata = [];


for kk = 1:numel(fname)
    kk
    filename = [pathname fname{kk}];
    
    
    %% Open the text file.
    fid = fopen(filename,'r');
    frewind(fid)
    
    if kk == 1 % for the first file, check number of columns
        for ii = 1:7
            fgetl(fid);
        end
        output.headers =  fgetl(fid);
        idx = strfind(output.headers,',');
        if idx(end)==numel(output.headers)
            Ncols = numel(idx) - 3;
        else
             Ncols = numel(idx) - 2;
        end
        
        formatSpec = ['%*s%*s%*s' repmat('%f',1,Ncols), '%[^\n\r]'];
        
        frewind(fid)        
    end
    
    info{2*kk-1} = fgetl(fid);
    info{2*kk} = fgetl(fid);
    
    %% Read columns of data according to the format.
    dataArray = textscan(fid, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for block=2:length(startRow)
        frewind(fid);
        dataArrayBlock = textscan(fid, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
        for col=1:length(dataArray)
            dataArray{col} = [dataArray{col};dataArrayBlock{col}];
        end
    end
    
    %% Close the text file.
    fclose(fid);
    
    %% Create output variable    
    output.ZPSdata = [output.ZPSdata; [dataArray{1:end-1}]];
    
    
    
end

output.info = info';
output.fname = fname{kk};
output.pathname = pathname;











