function [fname, cale] = readGTXasc(filename)
% ================================================================
%   import data from csv profiles provided by the Bruker GTx
%                  *** ithen *** 29/09/2014 ***
%                  only reads one file at a time
%                           %%%%%%%%%%%%%
% ================================================================


format long g

%%  user input
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% if NO input arg
if nargin==0
    pathname = 'S:\Science\Optics\Metrology Lab\Metrology Tests\';
    [fname,pathname] = uigetfile([pathname '*.asc'],'Select data file','MultiSelect','on');
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
prompt = {'Beamline','Optic name','Instrument'};
default = {'','','GTX'};
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
%% import data from GTx ASC file

for kk = 1:numel(fname)
    
    filename = fname{kk};
    
    % import data 
    fid = fopen([pathname, filename]);
    
     linen = 1;

    %  get header:   
%     while(linen<14)
%         tline = fgetl(fid);
%         config{linen} = tline;    
%         linen = linen + 1;
%     end
    stop = 0;
    while(stop == 0)
        tline = fgetl(fid);
        if strcmp(tline(1:8),'RAW_DATA')
            stop = 1;
        end
            config{linen} = tline;  
            linen = linen + 1; 
    end
    
    
    config = config'
    C = strsplit(config{2},'\t');
    Nx = str2num(C{2});
    C = strsplit(config{3},'\t');
    Ny = str2num(C{2});
    C = strsplit(config{7},'\t');
    pixel_size = str2num(C{4})*10^-3;% in mm
    C = strsplit(config{8},'\t');
    magnification = str2num(C{4});
    instrument = 'GTX';
    x = linspace(0,pixel_size*(Nx-1),Nx);
    y = linspace(0,pixel_size*(Ny-1),Ny);
    
    
    
    data = [];
    for ii = 1:Nx
        nline = textscan(fid,'%f',Ny,'TreatAsEmpty',{'Bad','bad','BAD'}); 
        nline = cell2mat(nline);
        data(ii,:) = nline';
    end
    
    fclose(fid);
    data = data';
    % assume that the data is in nm
    data = data*10^-9;
    
    VFM = 'y';
    
    %% save data
    % -----------------------------------------------------------    
    filename =  [filename(1:end-4) '__GTX'];    

    cale = mfilename('fullpath');
    cale = cale(1:end-length('_function_library\functions\readGTXasc'));
    cale = [cale '_data\_maps\'];
    fullname = [pathname fname{kk}];
    save([cale filename],  'x','y','pixel_size','data','fullname', 'config', 'optic_name','instrument', 'magnification', 'pixel_size');
    fname{kk} = filename;
end


%   =============================================
