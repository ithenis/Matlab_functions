function output = importZPSfileT(filename)
% syntax: ZPSdata = importZPSfile(filename)

% the function imports a longburst zygo zps file. it doesn't need to know the
% number of columns (channels) or datapoints

% filename = 'S:\Science\Optics\Metrology Lab\Metrology Tests\_One-off projects\_ZPS\_Zygo ZPS tests (June 2019)\datafiles\longburst\ZPSframe_OML_bimorph_ontheNOM_nomless_16ch_p1steps_updown_LongBurst_190729-120738_1.csv';
%% Initialize variables.
delimiter = ',';
startRow = 9;
endRow = inf;

[fname,pathname] = uigetfile([ '*.csv'],'Select data file');
% 
% pathname = 'S:\Science\Optics\Metrology Lab\Metrology Tests\_One-off projects\_ZPS\_Zygo ZPS tests (June 2019)\datafiles\longburst\';
% fname = 'ZPSframe_OML_bimorph_ontheNOM_nomless_16ch_jump0to1000_Timed_190729-131503.csv';


if fname == 0
    disp('user abort')
    fname = '';
    cale = '';
    return
end
output.ZPSdata = [];


filename = [pathname fname];


%% Open the text file.
fid = fopen(filename,'r');
frewind(fid)


    for ii = 1:7
        info{ii} = fgetl(fid);
    end
    output.headers =  fgetl(fid);
    idx = strfind(output.headers,',');
    if idx(end)==numel(output.headers)
         Ncols = numel(idx) - 2;
    else
         Ncols = numel(idx) - 1;
    end
    formatSpec = ['%*s%*s' repmat('%f',1,Ncols), '%[^\n\r]'];
    formatSpec1 = ['%*s%f' repmat('%*f',1,Ncols), '%[^\n\r]'];

        
aa = info{3};
idx = strfind(aa,',');
output.start_time = datenum(aa(idx+1:end))+5/24; % adjust time for the 5 hour shift

aa = info{4};
idx = strfind(aa,',');
output.dt = str2num(aa(idx(1)+1:idx(2)-1));


frewind(fid)   
%% Read columns of data according to the format.
dataArray = textscan(fid, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
frewind(fid) 
time = textscan(fid, formatSpec1, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
output.time = time{1,1};


%     
% for block=2:length(startRow)
%     
%     frewind(fid);
%     dataArrayBlock = textscan(fid, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
%     
%     for col=1:length(dataArray)
%         dataArray{col} = [dataArray{col};dataArrayBlock{col}];
%     end
% end



%% Close the text file.
fclose(fid);

%% Create output variable    
output.ZPSdata = [output.ZPSdata; [dataArray{1:end-1}]];



output.info = info';
output.fname = fname;
output.pathname = pathname;











