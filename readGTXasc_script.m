% ================================================================
%   import data from csv profiles provided by the Bruker GTx
%                  *** ithen *** 29/09/2014 ***
%                           %%%%%%%%%%%%%
% ================================================================


format long g

%%  user input
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
pathname = 'S:\Science\Optics\';
[filename,pathname] = uigetfile([pathname '*.asc'],'Select data file','MultiSelect','off');
if isempty(filename) % nothing selected
    disp('user abort')        
    return               
end

%% import data from GTx ASC file
% =======================================================================
    % import data 
    fid = fopen([pathname, filename]);
    
    linen = 1;
    stop = 0;
    while(stop == 0)
        tline = fgetl(fid);
        if strcmp(tline(1:8),'RAW_DATA')
            stop = 1;
        end
            config{linen} = tline;  
            linen = linen + 1; 
    end    
    
    config = config';
    C = strsplit(config{2},'\t');
    Nx = str2num(C{2});
    C = strsplit(config{3},'\t');
    Ny = str2num(C{2});
    C = strsplit(config{7},'\t');
    pixel_size = str2num(C{4})*10^-3;% in mm
    C = strsplit(config{10},'\t');
    magnification = str2num(C{4});
    instrument = 'GTX';
    x = linspace(0,pixel_size*(Nx-1),Nx);
    y = linspace(0,pixel_size*(Ny-1),Ny);    
    
    % extract data. this can be SLOW, keep checking if 'Busy', don't assume it crashed    
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
    
    % remove irrelevant variables
    clear fid ii linen stop tline C stop nline

