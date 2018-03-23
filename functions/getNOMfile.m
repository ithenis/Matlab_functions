% ================================================================
%       extract experimental data provided by the Diamond NOM
%                    INPUT MULTIPLE FILES
%                           HOME
%                *** ithen *** 29/07/2013 ***
% ================================================================


function [fname, cale, pathname] = getNOMfile(pathname);

format long g

% =======================================================================
%%  user input
if nargin==0
    pathname = 'Z:\';
end

[fname,pathname] = uigetfile([pathname '*.csv'],'Select data file','MultiSelect','on');

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

prompt = {'Measured surface facing up/side/down (u/s/d)','Optic name'};
default = {'',''};
answer = inputdlg(prompt,'title',1,default);

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
     
    if strcmp(filename((end-2):end),'csv')
        
% import data from the NOM csv file
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++        
           
        [fid,errmsg] = fopen([pathname filename]);
        if fid < 0
            disp(errmsg);
            disp('aborted')
            fname = '';
            cale = '';
            return
        end
        linen = 1;

% extract config       
        tline = '';
        while(~strcmp(tline,'</LINEHEADER>'))
            tline = fgetl(fid);
            config{linen} = tline;    
            linen = linen + 1;
            
        end
        write_time = config{3};
%         config = config';

% extract column headers
        frewind(fid);
        tline = textscan(fid,'%[^\n]','HeaderLines',linen-1);
        tline  = tline{1}(1);
        tline = textscan(tline {1},'%s','Delimiter','\t');
        ncol = numel(tline{1})-2;
        columnHeaders = tline{1};
        columnHeaders = columnHeaders';

        if ~strcmp(columnHeaders{7},'X data [urad]')||~strcmp(columnHeaders{8},'Y data [urad]')||~strcmp(columnHeaders{3},'Demand position')
            disp('Column headers don''t correspond. Aborting data import')
            C = [];
            return
        end
% extract data
        frewind(fid);
        data = textscan(fid,'%f','HeaderLines',linen,'CommentStyle', {'(', ')'});
        data = cell2mat(data);
        fprintf('data size %d\n',numel(data))
        data = reshape(data,[ncol, length(data)/ncol]);
        data = data';

        
        
        fclose(fid);
        
% \import data from the NOM csv file
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++        
        
        
        % get x [m]:
        x = data(:,3)*10^-3;
        dx = (x(end)-x(1))/(numel(x)-1);
        
        % get slope [rad]:
        if strcmpi(answer{1},'u')
            phi = data(:,8)*10^-6;   % measured surface was horizontal
            phi_roll = data(:,7)*10^-6;
        elseif strcmpi(answer{1},'s')
            phi = -data(:,7)*10^-6;   % measured surface was vertical
            phi_roll = data(:,8)*10^-6;
        else
            phi = -data(:,8)*10^-6;   % measured surface was horizontal
            phi_roll = -data(:,7)*10^-6;
        end
       
    else
        disp('This is not a csv file')
        return
    end
    
    %% save data
    % -----------------------------------------------------------  
    cale = mfilename('fullpath');
    cale = cale(1:end-length('_function_library\functions\getNOMfile'));
    cale = [cale '_data\'];
    
    filename =  filename(1:end-4);    
   
    save([cale filename], 'x', 'dx', 'phi', 'phi_roll', 'cale', 'filename', 'optic_name', 'VFM', 'write_time');
    fname{kk} = filename;
end

