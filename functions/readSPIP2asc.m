function [fname, pathname] = readSPIP2asc(fname)
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%         Import data from SPIP ascii maps (created by SPIP)
%            *** ithen *** 31/07/2013 ***
%           ***  revised 20/09/14 - import and apply mask    ***
%           ***  revised 21/08/15 - output mat file (like getNOMfile)  ***
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


format long g

%%  user input
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% if NO input arg
if nargin==0   
    pathname = 'S:\Science\Optics\Metrology Lab\Metrology Tests\';
    [fname,pathname] = uigetfile([pathname '*.asc'],'Select asc file','MultiSelect','on');
    if isempty(fname) % nothing selected
        disp('user abort')
        fname = '';
        pathname = '';
        return               
    end

% if just ONE input arg    
elseif nargin==1  
    if isdir(fname)  % IF it's a folder (no filename)
        [fname,pathname] = uigetfile([fname '*.asc'],'Select asc file');
        if ~(fname)
            disp('user abort')
            fname = '';
            pathname = '';
            return
        end
    elseif  ~exist(fname, 'file')  % IF wrong input (not proper path+filename)
        disp('filename invalid')
        disp('wrong filename, load aborted')
        fname = '';
        pathname = '';
        return
    else
        a = textscan(fname, '%s', 'delimiter','\');
        a = a{1}(end);
        pathname = fname(1:end-numel(a{1}));
        fname = a;
    end
end

% deal with multiple filenames
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

% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
prompt = {'Beamline','Optic name','Instrument (FIZ/XAM/AFM)'};
default = {'','','FIZ'};
answer = inputdlg(prompt,'title',1,default);
    
    
if isempty(answer)
    clear
    disp('user abort')
    fname = '';
    cale = '';
    return
end

optic_name = [answer{1} '_' answer{2}];
instrument = answer{3};

    
% =======================================================================
%% import data from SPIP asc file
for kk = 1:numel(fname)
    filename = fname{kk};
  
    fid = fopen([pathname filename]);
    linen = 1;

    %  get header:
    tline = '#';
    while(strcmp(tline(1),'#'))
        tline = fgetl(fid);
        config{linen} = tline;    
        linen = linen + 1;
    end
    
    linen = linen-1;
    config = config(1:linen-1)';   % see example at the end of the file
    
    a = textscan(config{5}, '%s %f', 'delimiter','=');
    Nx = a{2};

    if isempty(Nx)  % if the data a 1d profile
        
        a = textscan(config{6}, '%s %f', 'delimiter','=');    
        Nx = a{2};
        a = textscan(config{7}, '%s %s', 'delimiter',';');
        a = a{1};
        unit = textscan(a{1}, '%s %s', 'delimiter',':');
        if strcmp(unit{2},'[m]')||strcmp(unit{2},'µm')
            bx=10^0;
        elseif strcmp(unit{2},'[mm]')||strcmp(unit{2},'nm')
            bx=10^-3;
        else
            disp('problem with the units in the data file')
        end  
        a = textscan(config{7}, '%s %s', 'delimiter',';');
        a = a{2};
        unit = textscan(a{1}, '%s %s', 'delimiter',':');
        if strcmp(unit{2},'[µm]')||strcmp(unit{2},'µm')
            bz=10^-6;
        elseif strcmp(unit{2},'[nm]')||strcmp(unit{2},'nm')
            bz=10^-9;
        elseif strcmp(unit{2},'dnm / dµm')
            bz=10^-3;
        else
            disp('problem with the units in the data file')
        end 
        a = textscan(config{8}, '%s %f', 'delimiter','=');
        x_length = a{2}*bx;   % width [m]
        x = linspace(0,x_length,Nx);
        y = [];
        %  get data:
        frewind(fid);
 %% extract the actual data 
        data = textscan(fid,'%f',Nx*2,'HeaderLines',linen-1);
        data = cell2mat(data);

        data = (reshape(data,[2, Nx]))';
        data = data(:,2)*bz;

        fclose(fid);
        
        

    else    % if the data is a 2d map
        a = textscan(config{6}, '%s %f', 'delimiter','=');
        Ny = a{2};
        a = textscan(config{7}, '%s %f', 'delimiter','=');
        x_length = a{2}*10^-9;   % width [m]
        a = textscan(config{8}, '%s %f', 'delimiter','=');
        y_length = a{2}*10^-9;   % height [m]

        Npoints = Nx*Ny;

        % check units for z data. x and y are in [nm]
        a = textscan(config{11}, '%s %s', 'delimiter','=');    
        unit = a{2};
        if strcmp(unit,'[µm]')||strcmp(unit,'µm')
            b=10^-6;
        elseif strcmp(unit,'[nm]')||strcmp(unit,'nm')
            b=10^-9;
        else
            unit
            disp('problem with the units in the data file')
        end
        %  get data:
        frewind(fid);

 %% extract the actual data      
        data = textscan(fid,'%f',Npoints,'HeaderLines',linen+1);
        data = cell2mat(data);

        data = (reshape(data,[Nx, Ny]))'*10^-9;
        x = linspace(0,x_length,Nx);
        y = linspace(0,y_length,Ny);

% 
%         frewind(fid);
%         linenn = 1;
%         while ~feof(fid)
%             tline = fgetl(fid);
%             linenn=linenn+1;
%         end
% %      
        
        fclose(fid);
% 
%         if x_length>50*10^-6 %&& linenn > Npoints+linen % if not AFM and there is a mask, get mask
%             mask = dlmread([pathname filename],'\t',Npoints+linen+1, 0);    
%             mask(:,end) = [];
%             mask(mask==1) = nan;
%             mask = mask+1;
% 
%             data = data.*mask;
%         end 

    end

   
    
    %% save data
    % -----------------------------------------------------------  

        cale = mfilename('fullpath');
        cale = cale(1:end-length('_function_library\functions\readSPIP2asc'));
        cale = [cale '_data\_maps\'];
        
        % remove erroneous filetype extension from SPIP
        k = strfind(filename,'.map');
        if k
            filename = [filename(1:k-1) filename(k+4:end)];
        end
% remove '.asc' filetype extension
        k = strfind(filename,'.');        
        filename = filename(1:k(end)-1);
        
        k = strfind(filename,'.'); 
        if k
            filename(k)= 'p';
        end
      
        filename = [filename '__' instrument];
        fullname = [pathname fname{kk}];
        save([cale filename], 'x','y','data','fullname', 'config','optic_name', 'instrument');
       
        

end

    


%{ 
EXAMPLE:  2D data
    '# File Format = ASCII'
    '# Created by SPIP 4.3.1.0'
    [1x162 char]
    '# x-pixels = 561'
    '# y-pixels = 151'
    '# x-length = 1.58916e+008'
    '# y-length = 4.95966e+007'
    '# x-offset = -0.425664'
    '# y-offset = 0.826612'
    '# z-unit = [nm]'
    '# voidpixels =21647'
    '# Start of Data:'

or  1D data

    '# File Format = ASCII'
    [1x90  char]
    [1x131 char]
    '# Curve plot created by SPIP V.4.3.1.0'
    '# 16:35'   
    '# points   = 374'
    '# X-Axis: [mm]; Y-Axis: µm'
    '# length = 108.64'
    '# offset = 0'
    '# Start of Data:'
    '# x-phys	 y-val'
    '#------------------------------'
%}
