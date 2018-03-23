function [filename, pathname] = getZEISSfile(fullname);
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %         Import data from ZEISS ascii files 
    %            *** ithen *** 21/08/2015 ***
    %           ***  these are figure error maps   ***
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



format long g

if nargin==0   % IF no input arg
    pathname = 'S:\Science\Optics\Metrology Lab\Metrology Tests\';
    [filename,pathname] = uigetfile([pathname '*.asc'],'Select asc file');
    if ~(filename) % nothing selected
        disp('user abort')
        filename = '';
        pathname = '';
        return
    else
        fullname = [pathname, filename];    
    end
    
elseif nargin==1  % IF there is input arg
    if isdir(fullname)  % IF it's a folder
        [filename,pathname] = uigetfile([fullname '*.asc'],'Select asc file');
        if ~(fullname)
            disp('user abort')
            filename = '';
            pathname = '';
            return
        end
        fullname = [pathname, filename];
    elseif  ~exist(fullname, 'file')  % IF wrong input arg
        disp('pathname/filename invalid')
        disp('load aborted')
        return
    end
end



%% import data
    data = dlmread(fullname,'\t',1,0);

    nx = numel(unique(data(:,1)));
    ny = numel(unique(data(:,2)));
    
    % get x [m]:
    x = data(:,1)*10^-3;
    x = reshape(x,[nx, ny])';
    x = x(1,:);
    
    y = data(:,2)*10^-3;
    y = reshape(y,[nx, ny])';
    y = y(:,1);
    
    data = data(:,3)*10^-3;
    data = reshape(data,[nx, ny])';

    dx = (max(x(:))-min(x(:)))/(nx-1);
    dy = (max(y(:))-min(y(:)))/(ny-1);

        
   instrument = 'ZEISS';
    
    %% save data
    % -----------------------------------------------------------  
    prompt = {'Beamline','Optic name'};
    default = {'',''};
    answer = inputdlg(prompt,'title',1,default);

    if isempty(answer)
        clear
        disp('user abort')
        filename = '';    
        pathname = ''; 
        return
    end

    optic_name = [answer{1} '_' answer{2}];

    pathname = mfilename('fullpath');
    pathname = pathname(1:end-length('_function_library\functions\readZEISSasc'));
    pathname = [pathname '_data\_maps\'];

    filename =  [optic_name '_ZEISSdata'];      
    save([pathname filename], 'x','y','data','dx','dy', 'filename','optic_name', 'instrument');


