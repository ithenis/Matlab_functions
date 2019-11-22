function [fname, cale] = getGTXfile(filename);
% ================================================================
%   import data from csv profiles provided by the Bruker GTx
%                  *** ithen *** 29/09/2014 ***
%                  only reads one file at a time
%                           %%%%%%%%%%%%%
% ================================================================


format long g

% =======================================================================
%%  user input
if nargin==0
    pathname = 'S:\Science\Optics\Metrology Lab\Metrology Tests\';
    [fname,pathname] = uigetfile([pathname '*.csv'],'Select data file','MultiSelect','on');    
end

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


prompt = {'Measured surface facing UP (y/n)','Optic name'};
default = {'y',''};
answer = inputdlg(prompt,'title',1,default);
1
if isempty(answer)
    clear
    disp('user abort')
    fname = '';
    cale = '';
    return
end

VFM =  answer{1};
optic_name = answer{2};



% =======================================================================
%% import data from csv file

for kk = 1:numel(fname)
    
    filename = fname{kk};
    
    % import data 
    fid = fopen([pathname, filename])
    tline = '';

    
    tline = textscan(fid,'%[^\n]','HeaderLines',3);
    tline  = tline{1}(1);
    tline = textscan(tline {1},'%s','Delimiter',',');

    frewind(fid);
    data = textscan(fid,'%f','HeaderLines',4,'Delimiter',',','TreatAsEmpty',{'NA','na'});
    fclose(fid);

    % tweak data
    x_unit = tline{1}{1};
    x_unit = x_unit(end-2:end-1);
    z_unit = tline{1}{2};
    z_unit = z_unit(end-2:end-1);

    % the data is provided as 3 columns(there's a ghost 3rd column we have to get rid of)
    data = cell2mat(data);
    data  = reshape(data,[3 length(data)/3]);
    data  = data (1:2,:)';
    x = data (:,1);
    height = data (:,2);
    fprintf(['\n' filename '\n'])
    % apply units
    if strcmp(x_unit,'mm')
        disp('x is in mm')
        x = x*10^-3;
    elseif strcmp(x_unit,'µm')
        disp('x is in µm')
        x = x*10^-6;
    else
        disp('attention, x coordinate is not in mm')
        x_unit
    end
    
    dx = (x(end)-x(1))/(numel(x)-1);

    if strcmp(z_unit,'µm')
        height = height*10^-6;
        disp('height is in um')
    elseif strcmp(z_unit,'nm')
        height = height*10^-9;
        disp('height is in nm')
    elseif strcmp(z_unit,'mm')
        height = height*10^-3;
        disp('height is in mm')
    else
        disp('attention, z coordinate is not in mm')
        z_unit
    end
    
    
    VFM = 'y';
    %% save data
    % -----------------------------------------------------------    
    filename =  ['GTX_' filename(1:end-4)];    
%     [s,computername] = dos('ECHO %COMPUTERNAME%');    
%     if strcmp(computername(1:5),'CHUBB')
%         cale = 'd:\Work\Diamond\Matlab_work\_data\GTXdata\';    
%     else
%         cale = 'U:\Matlab_work\_data\GTXdata\';
%     end 
    cale = mfilename('fullpath');
    cale = cale(1:end-length('_function_library\functions\getGTXfile'));
    cale = [cale '_data\']
    save([cale filename], 'x', 'dx', 'height', 'optic_name','filename', 'VFM','x_unit','z_unit');
    fname{kk} = filename;
end


%   =============================================
