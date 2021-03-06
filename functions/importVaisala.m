function [datetime,pressure,temperature,humidity] = importVaisala(filename, startRow, endRow);
%IMPORTFILE1 Import numeric data from a text file as column vectors.
%   [DAY,TIME,PRESSURE,TEMPERATURE,HUMIDITY] = IMPORTFILE1(FILENAME) Reads
%   data from text file FILENAME for the default selection.
%
%   [DAY,TIME,PRESSURE,TEMPERATURE,HUMIDITY] = IMPORTFILE1(FILENAME,
%   STARTROW, ENDROW) Reads data from rows STARTROW through ENDROW of text
%   file FILENAME.
%
% Example:
%   [day,time,pressure,temperature,humidity] = importfile1('speckle.csv',10, 21972);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2019/07/30 11:17:41

%% Initialize variables.
if nargin<=2
    startRow = 1;
    endRow = inf;
end

if nargin == 0
    
  [filename,pathname] = uigetfile(['*.csv'],'Select data file','MultiSelect','on');
  filename  = [pathname filename];
    
end

%% Format for each line of text:
%   column1: datetimes (%{MM/dd/yy}D)
%	column2: text (%s)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%8s%9s%9f%7f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Remove white space around all cell columns.
dataArray{2} = strtrim(dataArray{2});

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
day = dataArray{:, 1};
times = cellstr(dataArray{:, 2});
pressure = dataArray{:, 3};
temperature = dataArray{:, 4};
humidity = dataArray{:, 5};
datetime = (strcat(day,{' '},times));
clear day times


% For code requiring serial dates (datenum) instead of datetime, uncomment
% the following line(s) below to return the imported dates as datenum(s).

% datetime = datenum(char(datetime),'mm/dd/yy HH:MM:SS');


