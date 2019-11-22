function getNANGOdata = importfile(filename)
%IMPORTFILE Import numeric data from a NANGO device text file as a matrix.



%% Initialize variables.
delimiter = '\t';
startRow = 10;
endRow = inf;
formatSpec = '%f%f%*s%*s%*s%[^\n\r]';
%%
if nargin<1
    pathname = 'S:\Science\Optics\Metrology Lab\Nano-angle generator\NOM tests using NANGO Dec 2018\Data\';
    [filename,pathname] = uigetfile([pathname '*.*'],'Select data file');
end
filename = [pathname filename]

if filename == 0
    disp('user abort')
    return

end


% Open the text file.
fileID = fopen(filename,'r')

textscan(fileID, '%[^\n\r]', startRow(1)-1, 'WhiteSpace', '', 'ReturnOnError', false);
data = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false, 'EndOfLine', '\r\n');
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'WhiteSpace', '', 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    for col=1:length(data)
        data{col} = [data{col};dataArrayBlock{col}];
    end
end

% Close the text file.
fclose(fileID);

% Create output variable
data = [data{1:end-1}];



