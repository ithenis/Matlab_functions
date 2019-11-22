% function output = importZPSfileLB(filename)
% syntax: ZPSdata = importZPSfile(filename)

% the function imports a longburst zygo zps file. it doesn't need to know the
% number of columns (channels) or datapoints

% filename = 'S:\Science\Optics\Metrology Lab\Metrology Tests\_One-off projects\_ZPS\_Zygo ZPS tests (June 2019)\datafiles\longburst\ZPSframe_OML_bimorph_ontheNOM_nomless_16ch_p1steps_updown_LongBurst_190729-120738_1.csv';
%% Initialize variables.
delimiter = ',';

startRow = 9;
endRow = inf;


%% Open the text file.
fid = fopen(filename,'r');
frewind(fid)

for kk = 1:7 
    fgetl(fid);
end

output.headers =  fgetl(fid);
idx = strfind(output.headers,',');



Ncols = numel(idx) - 3;
formatSpec = ['%*s%*s%*s' repmat('%f',1,Ncols), '%[^\n\r]'];

frewind(fid)
output.info{1} = fgetl(fid);
output.info{2} = fgetl(fid);


%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
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
output.ZPSdata = [dataArray{1:end-1}];
