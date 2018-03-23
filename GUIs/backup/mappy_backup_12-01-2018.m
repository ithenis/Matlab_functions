function varargout = mappy(varargin)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%  MAPPY manageS SPIP maps from miniFIZ and microXAM
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                % Begin initialization code - DO NOT EDIT
                gui_Singleton = 1;
                gui_State = struct('gui_Name',       mfilename, ...
                                   'gui_Singleton',  gui_Singleton, ...
                                   'gui_OpeningFcn', @mappy_OpeningFcn, ...
                                   'gui_OutputFcn',  @mappy_OutputFcn, ...
                                   'gui_LayoutFcn',  [] , ...
                                   'gui_Callback',   []);
                if nargin && ischar(varargin{1})
                    gui_State.gui_Callback = str2func(varargin{1});
                end

                if nargout
                    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
                else
                    gui_mainfcn(gui_State, varargin{:});
                end
                % End initialization code - DO NOT EDIT

                
% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function mappy_OpeningFcn(hObject, eventdata, handles, varargin)
    
    % clear axes
    axes(handles.axes1)
    cla
    axis off
    
    axes(handles.axes2)
    cla
    axis off
    
    % reset uicontrols
    handles = reset_uicontrols(hObject,handles);
    
    % reset variables
    handles.flag1 = 0; 
    handles.pathname = 'C:\Users\elt29493\Documents\MATLAB\_data\_maps';
    handles.colormap = jet(256);    
    set(handles.rb_horizontal,'Value',1)
    % Display message
    set (handles.t_mappy_says,'String',{'MAPPY says:';'   Ready for action '})
    
    
    % Choose default command line output for mappy
    handles.output = hObject;
     
    
  

    % Update handles structure
    guidata(hObject, handles);

    
    
% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function varargout = mappy_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
    varargout{1} = handles.output;

    
   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** MENU CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV


%% ------ MENU GENERAL ---------------------------------------------


% *** clear command panel  *** 
function m_clc_Callback(hObject, eventdata, handles) %#ok<*INUSD>
    evalin('base','clc')

    
    
% *** clear variables from  workkspace  *** 
function m_clear_Callback(hObject, eventdata, handles)
    evalin('base','clear')

  
    

  
% ------ subMENU COLORMAP ---------------------------------------------   


% *** send analysis to workspace  *** 
function m_colormap_Callback(hObject, eventdata, handles)

    
% *** JET  *** 
function m_color_jet_Callback(hObject, eventdata, handles)
    handles.colormap = jet(256);
    handles.axes1, colormap(handles.colormap);
    if ishandle(123)
        figure(123),colormap(handles.colormap);
    end

    % Update handles structure
    guidata(hObject, handles);

    
% *** HSV  *** 
function m_color_hsv_Callback(hObject, eventdata, handles)
    handles.colormap = hsv;
    handles.axes1; colormap(handles.colormap)
    if ishandle(123)
        figure(123),colormap(hsv);
    end

    % Update handles structure
    guidata(hObject, handles);

    
% *** GRAY  *** 
function m_color_gray_Callback(hObject, eventdata, handles)
    handles.colormap = gray(256);
    handles.axes1; colormap(handles.colormap)
    if ishandle(123)
        figure(123),colormap(handles.colormap);
    end

    % Update handles structure
    guidata(hObject, handles);

    
% *** BONE  *** 
function m_color_bone_Callback(hObject, eventdata, handles)
    handles.colormap = bone;
    handles.axes1; colormap(handles.colormap)
    if ishandle(123)
        figure(123),colormap(handles.colormap);
    end

    % Update handles structure
    guidata(hObject, handles);

    
% *** COPPER  *** 
function m_color_copper_Callback(hObject, eventdata, handles)
    handles.colormap = copper;
    handles.axes1; colormap(handles.colormap)
    if ishandle(123)
        figure(123),colormap(handles.colormap);
    end

    % Update handles structure
    guidata(hObject, handles);

    
% *** HOT  *** 
function m_color_hot_Callback(hObject, eventdata, handles)
    handles.colormap = hot;
    handles.axes1; colormap(handles.colormap)
    if ishandle(123)
        figure(123),colormap(handles.colormap);
    end

    % Update handles structure
    guidata(hObject, handles);

    
% *** COOL  *** 
function m_color_cool_Callback(hObject, eventdata, handles) 
    handles.colormap = cool;
    handles.axes1; colormap(handles.colormap)
    if ishandle(123)
        figure(123),colormap(handles.colormap);
    end

    % Update handles structure
    guidata(hObject, handles);

         
    
 
    
%% ------ MENU TO BASE ---------------------------------------------   
     
% *** send analysis to workspace  *** 
function m_analysis2base_Callback(hObject, eventdata, handles)    
    if ~isfield(handles,'mydata')
        % Display message
        set (handles.t_mappy_says,'String',{'MAPPY says:';'   Load a map first, cupcake'})
        return
    else        
        names = fieldnames(handles.mydata);
        for kk = 1:numel(names)
            aa = names{kk};
            eval([names{kk} '=handles.mydata.'  names{kk} ';']);
            assignin('base',eval('aa'),eval(eval('names{kk}')));
        end
    end
    
    if ~isfield(handles,'profile')
        return
    end
    names = {};
    names = fieldnames(handles.profile);
    for kk = 1:numel(names)
        aa = names{kk};
        eval([names{kk} '=handles.profile.'  names{kk} ';']);
        assignin('base',eval('aa'),eval(eval('names{kk}')));
    end
    

    
% *** send handles to workspace  ***     
function m_handles2base_Callback(hObject, eventdata, handles)
    assignin('base','handles',handles);    
    

    
% *** display namelist in command window  ***     
function m_namelist_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function m_profile2base_Callback(hObject, eventdata, handles)
    evalin('base','clear')
       if ~isfield(handles,'profile')
        return
    end
    names = {};
    names = fieldnames(handles.profile);
    for kk = 1:numel(names)
        aa = names{kk};
        eval([names{kk} '=handles.profile.'  names{kk} ';']);
        assignin('base',eval('aa'),eval(eval('names{kk}')));
    end
    



     
    
%% ------ MENU IMPORT ---------------------------------------------      

% --------------------------------------------------------------------
function m_importSPIPdata_Callback(hObject, eventdata, handles)
% ONLY WORKS FOR FIZEAU DATA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    set (handles.t_mappy_says,'String',{' mappy says:';'    start SPIP file import...'});    
    [filename, pathname, data_type] = readSPIPasc;
     
      if ~isempty(filename)
             handles.imported_fname = filename;
             handles.pathname = pathname;
             handles.flag1 = 1;
             % Update handles structure
             guidata(hObject, handles);    
             % Display message
             set (handles.t_mappy_says,'String',{' mappy says:';'    SPIP file imported'});
             pb_load_Callback(hObject, eventdata, handles);
        else
            % Display message
            set (handles.t_mappy_says,'String',{' mappy says:'; '   SPIP file import aborted'});
      end
% --------------------------------------------------------------------

      

function m_importZEISSdata_Callback(hObject, eventdata, handles)
    [filename, pathname] = readZEISSasc;
  
    if ~isempty(filename)
         handles.imported_fname = filename;
         handles.pathname = pathname;
         handles.flag1 = 1;
         % Update handles structure
         guidata(hObject, handles);    
         % Display message
         set (handles.t_mappy_says,'String',{' mappy says:';'    ZEISS file imported and loaded'});
         pb_load_Callback(hObject, eventdata, handles);
    else
        % Display message
        set (handles.t_mappy_says,'String',{' mappy says:'; '   ZEISS file import aborted'});
    end
% --------------------------------------------------------------------  



% --------------------------------------------------------------------
function m_importGTXdata_Callback(hObject, eventdata, handles)
    set (handles.t_mappy_says,'String',{' mappy says:';'    start GTX map import...'});
    tic
    [filename, pathname] = readGTXasc;
    t_file = toc/numel(filename)  
      if ~isempty(filename)
             handles.imported_fname = filename;
             handles.pathname = pathname;
             handles.flag1 = 1;
             % Update handles structure
             guidata(hObject, handles);    
             % Display message
             set (handles.t_mappy_says,'String',{' mappy says:';'    GTX file imported'});
             pb_load_Callback(hObject, eventdata, handles);
        else
            % Display message
            set (handles.t_mappy_says,'String',{' mappy says:'; '   GTX file import aborted'});
      end
    
    
    
%% ------ MENU BATCH PROCESS ---------------------------------------------
  
% --------------------------------------------------------------------
function m_batch_process_Callback(hObject, eventdata, handles)
  
    
% --------------------------------------------------------------------
function m_batch_profile_Callback(hObject, eventdata, handles)
    
    if ~isfield(handles,'mydata')
        % Display message
        set (handles.t_mappy_says,'String',{'MAPPY says:';'   Load a map first, cupcake'})
        return    
    end
    
    [fileN,pathN] = uigetfile([handles.pathname '\*.mat'],'MultiSelect','on');
    
    if iscell(fileN)
        fileN = sort(fileN);
    elseif fileN == 0
        disp('user abort')
        return
    else
        fileN = {fileN};
    end
    
    % check profile settings
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    ny = str2num(get(handles.e_profile_width,'String'));
        
    if strcmp(tag,'rb_horizontal')
        yc = handles.mydata.crosshair_xy(2)+handles.mydata.crop_xy(1,2)-1;        
        x = handles.mydata.x_map(1,:);
        height = zeros(size(handles.mydata.map,2),numel(fileN));
    elseif strcmp(tag,'rb_vertical') 
        yc = handles.mydata.crosshair_xy(1)+handles.mydata.crop_xy(1,1)-1;        
        x = handles.mydata.y_map(:,1);
        height = zeros(size(handles.mydata.map,1),numel(fileN));
    end    
        size(height)
      
    for kk = 1:numel(fileN)       
        load([pathN fileN{kk}]);        
        if strcmp(tag,'rb_horizontal')    
            height(:,kk) = squeeze(mean(data(round(yc-ny/2):round(yc+ny/2),handles.mydata.crop_xy(1,1):handles.mydata.crop_xy(2,1)),1))';
        else% vertical line            
            height(:,kk) = squeeze(mean(data(handles.mydata.crop_xy(1,2):handles.mydata.crop_xy(2,2),round(yc-ny/2):round(yc+ny/2)),2));
        end
    end
%     evalin('base','clear')
    assignin('base','batch_filenames',fileN');
    assignin('base','batch_height',height);
    assignin('base','batch_x',x);
    
     
        
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



%% ::::::::::::::::: LOAD :::::::::::::::::   


% ************   load map   ************   
function pb_load_Callback(hObject, eventdata, handles)
    pathN = handles.pathname;

    % check if there's all ready a namelist waiting to be loaded
    if handles.flag1 == 1
        fileN = handles.imported_fname;
    else
        [fileN,pathN] = uigetfile([pathN '\*.mat'],'MultiSelect','on');
    end

    % capable of loading multiple maps
    if iscell(fileN)
        fileN = sort(fileN);
    elseif fileN == 0
        disp('user abort')
        return
    else
        fileN = {fileN};
    end

    handles.pathname = pathN;
    handles.mydata = struct;
    % reset uicontrols
    handles = reset_uicontrols(hObject,handles);

    % Proceed with load
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    % fill mydata structure

    for kk = 1:numel(fileN)
        [pathN fileN{kk}]
        load([pathN fileN{kk}])
        
        
        if size(data,2)==1            
            fprintf('\n%s is a profile dataset', fileN{kk}(1:end-4));
            break            
        end
        
        if handles.flag1
            handles.mydata.namelist{kk} = fileN{kk};
        else
            handles.mydata.namelist{kk} = fileN{kk}(1:end-4);
        end 
                    
        handles.mydata.map(:,:,kk) = data;
        [handles.mydata.x_map(:,:,kk) handles.mydata.y_map(:,:,kk)] = meshgrid(x, y);
        
        
        
    end
    eval('handles.mydata.instrument = instrument;');
    a = num2str(handles.mydata.x_map(1,end,1)*10^3);
    if numel(a)>5
        a = a(1:5);
    end
    b = num2str(handles.mydata.y_map(end,1,1)*10^3);
    if numel(b)>5
        b = b(1:5);
    end
    
    handles.mydata.optic_name = optic_name;
    handles.mydata.VFM = 's';
    
    
    % update info uicontrols
    set(handles.t_optic_name,'String',optic_name);
    set(handles.t_W_H,'String',[a ' x ' b]);
    a = num2str(size(data,2));
    b = num2str(size(data,1));
    set(handles.t_Nx_Ny,'String',[a ' x ' b]);
    a = num2str((handles.mydata.x_map(1,2) - handles.mydata.x_map(1,1))*10^6);
    b = num2str((handles.mydata.y_map(2,1) - handles.mydata.y_map(1,1))*10^6);
    set(handles.t_dx_dy,'String',[a ' x ' b]);
    
    handles.mydata.dx = handles.mydata.x_map(1,2) - handles.mydata.x_map(1,1);
    handles.mydata.dy = handles.mydata.y_map(2,1) - handles.mydata.y_map(1,1);
    
    % set current point, roi and crop coordinates
    [y,x,~] = size(handles.mydata.map);
    handles.mydata.roi_xy = [1 1; x y];
    handles.mydata.crop_xy = [1 1; x y];
    handles.mydata.crosshair_xy = [round(x/2) round(y/2)]; 
    handles.mydata.profile_xy = [1 round(y/2);x round(y/2)];
    
    set(handles.e_crosshair_x,'String',num2str(handles.mydata.crosshair_xy(1)));
    set(handles.e_crosshair_y,'String',num2str(handles.mydata.crosshair_xy(2)));
    set(handles.e_profile_width,'String',num2str(1));
    set(handles.e_profile_x1,'String',num2str(1));
    set(handles.e_profile_x2,'String',num2str(x));
    
    set(handles.uipanel2,'Title',[fileN{1}(1:end-4)]);
    
    handles = refresh_axes(handles);
  
    disp('done load')
    handles.flag1 = 0;

    % Update handles structure
    guidata(hObject, handles);


% ************   sort datasets    ************   
function pb_sort_Callback(hObject, eventdata, handles)
    aa = Sorter(handles.mydata.namelist);
    
    for ii = 1:numel(aa)       
        index(ii) = find(strcmp(handles.mydata.namelist, aa{ii}));        
    end

%     set(handles.lb_loaded_datasets,'Value',1,'String',aa) 
    
    % rearrange all data
    handles.mydata.namelist = aa;    
    handles.mydata.map = handles.mydata.map(:,:,index);
    handles.mydata.x_map = handles.mydata.x_map(:,:,index);
    handles.mydata.y_map = handles.mydata.y_map(:,:,index);
    
    % Update handles structure
    guidata(hObject, handles); 


    
% ************   save data    ************  
function pb_save_Callback(hObject, eventdata, handles)    
    disp('Inactive')    
    
    


%% ::::::::::::::::: CROP :::::::::::::::::       
    
% ************   manually crop loaded map   ************     
function pb_manual_crop_Callback(hObject, eventdata, handles)
    
    if ~isfield(handles.mydata,'map')
        disp('Load a map to crop from, you clot')
        return
    end
    
    go = 1;
    while go==1
        figure(234),set(gcf,'color','w',  'Position', [100, 100, 700, 500]);
        imagesc(handles.mydata.map(:,:,1))
        axis equal
        colormap(handles.colormap)
        [x,y] = ginput(2);
        x = round(x);   x = sort(x);
        y = round(y);   y = sort(y);
        
        figure(234)
        hold on
        rectangle('Position',[x(1),y(1),x(2)-x(1),y(2)-y(1)],...
            'EdgeColor','r','LineWidth',2,'LineStyle','--')
        hold off
        
        % check with user if cropped rectangle is ok
        button = questdlg('Happy?','Map crop','yes','try again','cancel' ,'yes');
        switch button
            case 'yes'
                go = 0;
            case 'try again'
                go = 1;
            case 'cancel'
                go = 0;  %#ok<*NASGU>
                disp('CROP: user abort')
                close(234)
                return
        end
    end
    close(234)
    
    % do the crop
    handles.mydata.map = handles.mydata.map(y(1):y(2),x(1):x(2),:);    
    handles.mydata.x_map = handles.mydata.x_map(y(1):y(2),x(1):x(2),:);
    handles.mydata.x_map = handles.mydata.x_map - handles.mydata.x_map(1,1,1);
    handles.mydata.y_map = handles.mydata.y_map(y(1):y(2),x(1):x(2),:);
    handles.mydata.y_map = handles.mydata.y_map - handles.mydata.y_map(1,1,1);
    
    % save crop coordinates
    handles.mydata.crop_xy = [x y];       
    a = num2str(handles.mydata.x_map(1,end,1)*10^3);
    b = num2str(handles.mydata.y_map(end,1,1)*10^3);
    set(handles.t_W_H,'String',[a(1:5) ' x ' b(1:5)]);
    a = num2str(size(handles.mydata.map,2));
    b = num2str(size(handles.mydata.map,1));
    set(handles.t_Nx_Ny,'String',[a ' x ' b]);
    a = num2str((handles.mydata.x_map(1,2,1)-handles.mydata.x_map(1,1,1))*10^6);
    b = num2str((handles.mydata.y_map(2,1,1)-handles.mydata.y_map(1,1,1))*10^6);
    set(handles.t_dx_dy,'String',[a(1:5) ' x ' b(1:5)]);
    
    % set current point, roi and crop coordinates
    [y,x,~] = size(handles.mydata.map);
    handles.mydata.roi_xy = [1 1; x y];
    handles.mydata.crosshair_xy = [round(x/2) round(y/2)];  
    handles.mydata.profile_xy = [1 round(y/2);x round(y/2)];
    
    
    set(handles.e_crosshair_x,'String',num2str(handles.mydata.crosshair_xy(1)));
    set(handles.e_crosshair_y,'String',num2str(handles.mydata.crosshair_xy(2))); 
    set(handles.rb_horizontal,'Value',1);
    set(handles.e_profile_x1,'String',num2str(1));
    set(handles.e_profile_x2,'String',num2str(x));
    
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
     
       
 % ************  auto crop ROI from loaded map    ************   
function pb_autocrop_Callback(hObject, eventdata, handles)
    if ~isfield(handles.mydata,'map')
        disp('Load a map to crop from, you clot')
        return
    end
        
    data = map_trim(handles.mydata.map(:,:,1));
    if numel(data.ix)==0||numel(data.iy)==0
        disp('use manual cropping')
        return
    end
    
    handles.mydata.map = handles.mydata.map(data.iy, data.ix,:);        
    handles.mydata.x_map = handles.mydata.x_map(data.iy, data.ix,:);
    handles.mydata.x_map = handles.mydata.x_map - handles.mydata.x_map(1);
    handles.mydata.y_map = handles.mydata.y_map(data.iy, data.ix,:);
    handles.mydata.y_map = handles.mydata.y_map - handles.mydata.y_map(1);
    
    % save crop coordinates
    x = [data.ix(1); data.ix(end)];  
    y = [data.iy(1); data.iy(end)]; 

    
    handles.mydata.crop_xy = [x y];       
    a = num2str(handles.mydata.x_map(1,end,1)*10^3);
    b = num2str(handles.mydata.y_map(end,1,1)*10^3);
    set(handles.t_W_H,'String',[a(1:5) ' x ' b(1:5)]);
    a = num2str(size(handles.mydata.map,2));
    b = num2str(size(handles.mydata.map,1));
    set(handles.t_Nx_Ny,'String',[a ' x ' b]);
    a = num2str((handles.mydata.x_map(1,2,1)-handles.mydata.x_map(1,1,1))*10^6);
    b = num2str((handles.mydata.y_map(2,1,1)-handles.mydata.y_map(1,1,1))*10^6);
    set(handles.t_dx_dy,'String',[a(1:5) ' x ' b(1:5)]);
    
    % set current point, roi and crop coordinates
    [y,x,~] = size(handles.mydata.map);
    handles.mydata.roi_xy = [1 1; x y];
    handles.mydata.crosshair_xy = [round(x/2) round(y/2)];      
    handles.mydata.profile_xy = [1 round(y/2);x round(y/2)];
    
    
    set(handles.e_crosshair_x,'String',num2str(handles.mydata.crosshair_xy(1)));
    set(handles.e_crosshair_y,'String',num2str(handles.mydata.crosshair_xy(2))); 
    set(handles.rb_horizontal,'Value',1);
    set(handles.e_profile_x1,'String',num2str(1));
    set(handles.e_profile_x2,'String',num2str(x));
    
   
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
            
    
    
function pb_reset_crop_Callback(hObject, eventdata, handles)
    disp('inactive')


    
    
%% ::::::::::::::::: Tweak ::::::::::::::::: 



function pb_average_Callback(hObject, eventdata, handles)
   if numel(size(handles.mydata.map))==3
       if size(handles.mydata.map,3)>1
           handles.mydata.averaged_map = sum(handles.mydata.map,3)/size(handles.mydata.map,3);
       end
   end
   % Update handles structure
    guidata(hObject, handles);    
       


function pb_subtract_Callback(hObject, eventdata, handles)    
   if (~isfield(handles,'mydata')) | numel(size(handles.mydata.map))~=2
       disp('load one map and retry')
       return
   end
    
   [fileN,pathN] = uigetfile([handles.pathname '\*.mat']);
   if fileN == 0
        disp('user abort')
        return
    end

   load([pathN fileN]);
   
   if size(data)~=size(handles.mydata.map)
       disp('Maps are of different sizes')
       return
   end
   
   handles.mydata.map = handles.mydata.map - data;
   handles = refresh_axes(handles);
   disp('done subtraction')
   
   % Update handles structure
   guidata(hObject, handles);  


% *********  removes surface polynomial  *********
function pb_remove_poly_Callback(hObject, eventdata, handles)   
   if (~isfield(handles,'mydata')) | numel(size(handles.mydata.map))~=2
       disp('load one map and retry')
       return
   end
   % create polynomial surface
   
   if find(isnan(handles.mydata.map))
       disp('remove all non-values')
       return
   end
   
   
    prompt = {'x order (0 to 4)','y order (0 to 4)'};
    default = {'1','1'};
    answer = inputdlg(prompt,'title',1,default);

    if isempty(answer)
        return
    end

    xn =  answer{1};
    yn = answer{2};
    
    
   
    f = fit( [handles.mydata.x_map(:), handles.mydata.y_map(:)], handles.mydata.map(:), ['poly' xn yn] );
    surffit = (f(handles.mydata.x_map,handles.mydata.y_map));
    surffit = reshape(surffit, size(handles.mydata.map));
    
    handles.mydata.map = handles.mydata.map-surffit;
    
    handles = refresh_axes(handles);
    
    
    
   
   % Update handles structure
   guidata(hObject, handles);  

   

% ********* performs a number of iterations to fill in the NaN values in the map.
function pb_fill_nan_Callback(hObject, eventdata, handles)

if find(isnan(handles.mydata.map))
    jj = numel(find(isnan(handles.mydata.map)))   
        
    flag = 0;
    ctr = 1;
    while (jj>0) && (ctr<20)
        ctr
        ctr = ctr+1;
        imap = find_nans(handles.mydata.map); 
        if flag
            disp('static')
            break
            return
        end
        
        for kk = 1:max(imap(:))  
            
            [iy,ix]=ind2sub(size(handles.mydata.map),find(imap==kk));            
            x1 = max(ix(1)-1,1);
            x2 = min(ix(end)+1,size(handles.mydata.map,2));
            y1 = max(iy(1)-1,1);
            y2 = min(iy(end)+1,size(handles.mydata.map,1));
            if numel(handles.mydata.map(y1:y2,x1:x2))<100000                
                handles.mydata.map(y1:y2,x1:x2) = patch_map(handles.mydata.map(y1:y2,x1:x2));
            else
                disp('map too big')
                fprintf('map size: %d',numel(handles.mydata.map(y1:y2,x1:x2)));                
                break
                return
            end
        end
        jj1 = numel(find(isnan(handles.mydata.map)));
        if jj1==jj
            flag=1
        else
            jj = jj1
        end
        handles = refresh_axes(handles); 
        
        
        
    end
else
    disp('no NaN values')
    handles = refresh_axes(handles);    
end

    
   
   % Update handles structure
   guidata(hObject, handles);  
    
    

%% ::::::::::::::::: RMSE ::::::::::::::::: 
    

% *********   select ROI window    ************      
function pb_rms_ROI_Callback(hObject, eventdata, handles)  
    [x,y] = ginput(2);
    x = round(x);   x = sort(x);
    y = round(y);   y = sort(y);
    handles.mydata.roi_xy = [x y];
    if numel(size(handles.mydata.map))<3
        roi = handles.mydata.map(y(1):y(2),x(1):x(2));
        roi = patch_map(roi); 
        rmse = rms_map(roi)*10^9; % in nm
        rmse = round(rmse*10^3)/10^3;

        set(handles.t_rmse,'String',[num2str(rmse) ' nm'])
    else
        roi = handles.mydata.map(y(1):y(2),x(1):x(2),:);
        roi(:,:,1) = patch_map(roi(:,:,1)); 
        for kk = 2:size(roi,3)
            roi(:,:,kk) = patch_map(roi(:,:,kk)); 
            rmse(kk-1) = rms_map(roi(:,:,kk)-roi(:,:,kk-1))*10^9; % in nm
            rmse(kk-1) = round(rmse(kk-1)*10^3)/10^3;
        end
        rmse'
    end
        
    handles = refresh_axes(handles);
    
   % Update handles structure
   guidata(hObject, handles);  

   
% *********       ************    
function pb_full_rms_Callback(hObject, eventdata, handles)
    [y x] = size(handles.mydata.map);
    x = [1 x]';
    y = [1 y]';
    
    handles.mydata.roi_xy = [x y];
    if find(isnan(handles.mydata.map(1,:,1)))
        disp('apply autocrop')
        return
    end
    if numel(size(handles.mydata.map))<3
        roi = handles.mydata.map(y(1):y(2),x(1):x(2));
        roi = patch_map(roi); 
        rmse = rms_map(roi)*10^9; % in nm
        rmse = round(rmse*10^3)/10^3;

        set(handles.t_rmse,'String',[num2str(rmse) ' nm'])
    else
        roi = handles.mydata.map(y(1):y(2),x(1):x(2),:);
        roi(:,:,1) = patch_map(roi(:,:,1)); 
        for kk = 2:size(roi,3)
            roi(:,:,kk) = patch_map(roi(:,:,kk)); 
            rmse(kk-1) = rms_map(roi(:,:,kk)-roi(:,:,kk-1))*10^9; % in nm
            rmse(kk-1) = round(rmse(kk-1)*10^3)/10^3;
        end
        rmse'
    end
        
    handles = refresh_axes(handles);
    
    % Update handles structure
   guidata(hObject, handles);  


     
%% ::::::::::::::::: DISPLAY map :::::::::::::::::   


% *********   select display mode    ************    
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)

    sel = get(hObject,'Tag');
    
    switch sel
        case 'rb_image'
          
            
        case 'rb_mesh'            
           
        
        case 'rb_surf'      
       
    
        case 'rb_cloud'            
    
    end
   
    
    
% ************   pop out figure    ************  
function pb_pop_out_fig_Callback(hObject, eventdata, handles)
    
    if ishandle(123)
        figure(123)
    else
        figure(123),set(gcf,'color','w',  'Position', [100, 100, 700, 500]);  
    end
    
        
    if get(handles.rb_surf,'Value')==1
        if size(handles.mydata.map,2)>1000
            step = floor(size(handles.mydata.map,2)/300);
        else
            step = 2;
        end
        x = handles.mydata.x_map(1:step:end,1:step:end)*10^3;
        y = handles.mydata.y_map(1:step:end,1:step:end)*10^3;
        map = handles.mydata.map(1:step:end,1:step:end)*10^6;
        spanZ = max(map(:)) - min(map(:));
        spanX = max(x(:)) - min(x(:));
        spanY = max(y(:)) - min(y(:)) ;
        fact = (spanZ/min(spanX,spanY));
        
        surf(x,y,map, 'LineStyle', 'none', 'FaceColor', 'interp')
        colormap(jet)
        camlight right
        daspect([1 1 fact*4]);
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold')
        zlabel('Z-axis [nm]','Fontsize',12,'FontWeight','bold')
        
    elseif get(handles.rb_image,'Value')==1
        x = handles.mydata.x_map(1,:,1)*10^3;
        y = handles.mydata.y_map(:,1,1)*10^3;  
        spanX = max(x(:)) - min(x(:));
        spanY = max(y(:)) - min(y(:));
        ratio = spanX/spanY*0.8;
        
        W = 800;
        
        figure(123), set(gcf, 'color','w','Position',[100,100, W, W/ratio])
        imagesc(x,  y  ,handles.mydata.map(:,:,1)*10^6),   axis tight
        colormap(handles.colormap)
        set(gca,'dataAspectRatio',[1 1 1],'xtick',[],'ytick',[])
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold')
        title('Surface map [um]','Fontsize',12,'FontWeight','bold')
        
    elseif get(handles.rb_profile,'Value')==1
       close(123)  
       ax2 = handles.axes2;       
       h = copyobj(ax2,figure(124));
       set(gcf,'color','w','position',[50,50,800,350])
       set(h, 'Units', 'normalized', 'Position', [0.1 0.15 0.8 0.75]);
      

    end
   
    
    
%% :::::::::::::::::  PROFILE ANALYSIS  :::::::::::::::::  


% ************   choose direction:  horizontal; vertical or custom   ************     
function rbp_horiz_vert_SelectionChangeFcn(hObject, eventdata, handles)
    [y,x,~] = size(handles.mydata.map);
    if get(handles.rb_horizontal,'Value')         
        handles.mydata.profile_xy = [1  handles.mydata.crosshair_xy(2);...
                                     x  handles.mydata.crosshair_xy(2)]; 
        
        set(handles.e_profile_x1,'string',num2str(1));
        set(handles.e_profile_x2,'string',num2str(x));  
        set(handles.e_profile_y1,'string',num2str(handles.mydata.crosshair_xy(2)));
        set(handles.e_profile_y2,'string',num2str(handles.mydata.crosshair_xy(2))); 
        
        handles = refresh_axes(handles);
        
    elseif get(handles.rb_vertical,'Value')    
        handles.mydata.profile_xy = [handles.mydata.crosshair_xy(1)  1;...
                                     handles.mydata.crosshair_xy(1)  y];
        set(handles.e_profile_x1,'string',num2str(handles.mydata.crosshair_xy(1)));
        set(handles.e_profile_x2,'string',num2str(handles.mydata.crosshair_xy(1)));                          
        set(handles.e_profile_y1,'string',num2str(1));
        set(handles.e_profile_y2,'string',num2str(y));  
        
        handles = refresh_axes(handles);
        
    elseif get(handles.rb_custom,'Value')
        disp('standby for custom output')
        handles.mydata.profile_xy = zeros(2,2); 
        set(handles.e_profile_width,'string','1');
        set(handles.e_profile_x1,'string','');
        set(handles.e_profile_x2,'string','');
        set(handles.e_profile_y1,'string','');
        set(handles.e_profile_y2,'string','');
        % Update handles structure
        guidata(hObject, handles);
        pb_manual_profile_idx_Callback(hObject, eventdata, handles);        
    end
    % Update handles structure
    guidata(hObject, handles);
    
    
% ************   manually pick crosshair in map    ************   
function pb_manual_crosshair_Callback(hObject, eventdata, handles)
   
    if strcmp(get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag'),'rb_custom') 


    else       
        axes(handles.axes1)
        [x,y] = ginput(1);    
        handles.mydata.crosshair_xy = [round(x) round(y)];        
        set(handles.e_crosshair_x,'String',num2str(round(x)));
        set(handles.e_crosshair_y,'String',num2str(round(y)));         
        
    end
    handles = refresh_axes(handles);
    % Update handles structure
    guidata(hObject, handles); 
 
    
% ************   set crosshair at centre of the 2d map   ************      
function pb_centre_crosshair_Callback(hObject, eventdata, handles) 
    if strcmp(get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag'),'rb_custom') 
        return
    else 
        [y,x,z] = size(handles.mydata.map);

        handles.mydata.crosshair_xy(1) = round(x/2);
        handles.mydata.crosshair_xy(2) = round(y/2);

        set(handles.e_crosshair_x,'String',num2str(handles.mydata.crosshair_xy(1)));
        set(handles.e_crosshair_y,'String',num2str(handles.mydata.crosshair_xy(2)));

        handles = refresh_axes(handles);

        % Update handles structure
        guidata(hObject, handles);    
    end  
    
    
% ************   set crosshair x coordinate   ************   
function e_crosshair_x_Callback(hObject, eventdata, handles) %#ok<*DEFNU,*INUSL>
    x = str2num(get(hObject,'String')); %#ok<ST%#ok<*MSNU> 2NM>
    x = round(x);
    if x<=size(handles.mydata.map,2)
        handles.mydata.crosshair_xy(1) = x;        
    else
        set(hObject,'String',num2str(handles.mydata.crosshair_xy(1)))
    end
    
    handles = refresh_axes(handles);

    % Update handles structure
    guidata(hObject, handles);
        
    
% ************   set crosshair y coordinate    ************   
function e_crosshair_y_Callback(hObject, eventdata, handles)
    y = str2num(get(handles.e_crosshair_y,'String')); %#ok<*ST2NM>
    y = round(y);
    if y<=size(handles.mydata.map,1)
        handles.mydata.crosshair_xy(2) = y;
    else
        set(hObject,'String',num2str(handles.mydata.crosshair_xy(2)))
    end
    
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
     
   

% ************   update display for cursor thickness   ************
function e_profile_width_Callback(hObject, eventdata, handles)
    if get(handles.rb_custom,'Value')
        set(handles.e_profile_width,'String','1')
        disp ('for custom profiles width must be 1 pixel')
        return
    end
    
    handles = refresh_axes(handles);
   
   
   % Update handles structure
    guidata(hObject, handles);
 



    
function handles = pb_manual_profile_idx_Callback(hObject, eventdata, handles)
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    axes(handles.axes1)
    if  strcmp(tag,'rb_horizontal') 
        [x,~] = ginput(2); 
        if ~isempty(get(get(gca,'XLabel'),'String'))% if in the plot axes
            
            x_plot = squeeze(handles.mydata.x_map(1,handles.mydata.profile_xy(1,1):handles.mydata.profile_xy(2,1),1))*10^3;            
            [~,x(1)] = (min(abs(x_plot-x(1))));
            [~,x(2)] = (min(abs(x_plot-x(2))));
            % because the plot axes zooms in, (the image axes doesn't), we need to shift new x1 by previous x1
            x = x + handles.mydata.profile_xy(1,1);
        else
            x = round(x);   
        end 
        handles.mydata.profile_xy(:,1) = sort(x);
        
        set(handles.e_profile_x1,'String',num2str(x(1)));
        set(handles.e_profile_x2,'String',num2str(x(2)));
        
    elseif  strcmp(tag,'rb_vertical') 
        [x,y] = ginput(2);    
        if ~isempty(get(get(gca,'XLabel'),'String'))% if in the plot axes
            y = x;            
            y_plot = squeeze(handles.mydata.y_map(handles.mydata.profile_xy(1,2):handles.mydata.profile_xy(2,2),1,1))*10^3;
            [~,y(1)] = (min(abs(y_plot-y(1))));
            [~,y(2)] = (min(abs(y_plot-y(2))));
            % because the plot axes zooms in, (the image axes doesn't), we need to shift new x1 by previous x1
            y = y + handles.mydata.profile_xy(1,2);
        else
            y = round(y);  
        end           
        handles.mydata.profile_xy(:,2) = sort(y);   
        set(handles.e_profile_y1,'String',num2str(y(1)));
        set(handles.e_profile_y2,'String',num2str(y(2)));
    elseif strcmp(tag,'rb_custom') 
        axes(handles.axes1)
        [x,y] = ginput(2);
        handles.mydata.profile_xy = [round(x) round(y)];
        handles = pb_create_profile_Callback(hObject, eventdata, handles);
        set(handles.e_profile_x1,'String',num2str(handles.mydata.profile_xy(1,1)));
        set(handles.e_profile_x2,'String',num2str(handles.mydata.profile_xy(2,1)));
        set(handles.e_profile_y1,'String',num2str(handles.mydata.profile_xy(1,2)));
        set(handles.e_profile_y2,'String',num2str(handles.mydata.profile_xy(2,2)));
    end
    handles = refresh_axes(handles);
    
    
    % Update handles structure
    guidata(hObject, handles);

    
    
function e_profile_x1_Callback(hObject, eventdata, handles)
    idx1 = str2num(get(hObject,'string'));
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    if strcmp(tag,'rb_horizontal')
        handles.mydata.profile_xy(1,1) = idx1;
    elseif strcmp(tag,'rb_vertical')
        handles.mydata.profile_xy(1,2) = idx1;
    else
        set(hObject,'string','');
    end
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
    

    
function e_profile_x2_Callback(hObject, eventdata, handles)
    idx2 = str2num(get(hObject,'string'));
    
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    if strcmp(tag,'rb_horizontal')
        handles.mydata.profile_xy(2,1) = idx2;
    elseif strcmp(tag,'rb_vertical')
        handles.mydata.profile_xy(2,2) = idx2;
    else
        set(hObject,'string','');
    end
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);

  
% ************   extract profile    ************  
function handles = pb_create_profile_Callback(hObject, eventdata, handles)

    % only analyses the first map    
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    ny = str2num(get(handles.e_profile_width,'String'));
    data = handles.mydata.map(:,:,1);
    
    handles.profile.optic_name = handles.mydata.optic_name;
    handles.profile.VFM = handles.mydata.VFM;
    handles.profile.instrument = handles.mydata.instrument;
    handles.profile.filename = handles.mydata.namelist{1};
    % extract horizontal or vertical profile and x/y-coordinates 
    if strcmp(tag,'rb_horizontal')   
        yc = handles.mydata.crosshair_xy(2);
        handles.profile.x = handles.mydata.x_map(yc,handles.mydata.profile_xy(1,1):handles.mydata.profile_xy(2,1),1)';        
        handles.profile.dx = handles.profile.x(2) - handles.profile.x(1);
        handles.profile.height = squeeze(mean(data(round(yc-ny/2):round(yc+ny/2),handles.mydata.profile_xy(1,1):handles.mydata.profile_xy(2,1)),1))';    
        
    elseif strcmp(tag,'rb_vertical')% vertical line
        yc = handles.mydata.crosshair_xy(1);
        handles.profile.x = handles.mydata.y_map(handles.mydata.profile_xy(1,2):handles.mydata.profile_xy(2,2),yc,1);
        handles.profile.dx = handles.profile.x(2) - handles.profile.x(1);
        handles.profile.height = squeeze(mean(data(handles.mydata.profile_xy(1,2):handles.mydata.profile_xy(2,2),round(yc-ny/2):round(yc+ny/2)),2));
        
    elseif strcmp(tag,'rb_custom')% random line
         
        [profPointsInd] = my_profile(handles.mydata.map, handles.mydata.profile_xy);
        handles.profile.height = handles.mydata.map(profPointsInd);    
        dx = (handles.mydata.profile_xy(2,1)-handles.mydata.profile_xy(1,1))/(numel(handles.profile.height)-1);
        dy = (handles.mydata.profile_xy(2,2)-handles.mydata.profile_xy(1,2))/(numel(handles.profile.height)-1);
        handles.profile.dx = sqrt(dx^2 + dy^2);
        handles.profile.x = 0:handles.profile.dx:handles.profile.dx*(numel(handles.profile.height)-1);
    end

        handles.profile.height = handles.profile.height - linspace(handles.profile.height(1),handles.profile.height(end),numel(handles.profile.height))';

        handles.profile.phi = get_slope(handles.profile.height, handles.profile.x);
        handles.profile.phi_roll = zeros(size(handles.profile.phi));
    
    % Update handles structure
    guidata(hObject, handles);
    


    
    
    
      
        
% ************   fit profile to polynomial    ************       
function pb_polyfit_Callback(hObject, eventdata, handles)
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    deg = str2num(get(handles.e_deg_poly,'String'));
    data = handles.mydata.map(:,:,1);
    ny = str2num(get(handles.e_profile_width,'String'));
    
    if strcmp(tag,'rb_horizontal')
        yc = handles.mydata.crosshair_xy(2);        
        x = handles.mydata.x_map(yc,:,1);
        height = squeeze(mean(data(round(yc-ny/2):round(yc+ny/2),:),1));
    else        
        yc = handles.mydata.crosshair_xy(1);
        x = handles.mydata.y_map(:,yc,1)';
        height = squeeze(mean(data(:,round(yc-ny/2):round(yc+ny/2)),2))';
    end
    
    height = height-mean(height);
    fitcoef4 = polyfit(x, height, deg);
    handles.profile.fitted4 = polyval(fitcoef4,x);
    handles.profile.fitted_height = height - handles.profile.fitted4;
    
    figure(12)            
        plot(x*10^3, 10^6*height,...
             x*10^3, 10^6*handles.profile.fitted_height,'LineWidth',2)            
        ylabel('Figure [um]','Fontsize',12,'FontWeight','bold')

    % Update handles structure
    guidata(hObject, handles);

 

    

  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%%                  *** INBUILT FUNCTIONS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



function handles = refresh_axes(handles)
    if ~isfield(handles,'mydata')  % if the data hasn't been loaded just yet  
        return
    end    
  
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    ny = str2num(get(handles.e_profile_width,'String'));
    
    % image plot (axes 1)  
    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    axes(handles.axes1)
        cla
        imagesc(handles.mydata.map(:,:,1)*10^9),axis image,axis off
        colormap(handles.colormap)        
        hold on   
        rectangle('Position',[handles.mydata.roi_xy(1,1),handles.mydata.roi_xy(1,2),...
                    handles.mydata.roi_xy(2,1)-handles.mydata.roi_xy(1,1),handles.mydata.roi_xy(2,2)-handles.mydata.roi_xy(1,2)],...
        'EdgeColor','w','LineWidth',1,'LineStyle','--')   
        
   
    if strcmp(tag,'rb_vertical')  % vertical profile 
        plot([handles.mydata.crosshair_xy(1) handles.mydata.crosshair_xy(1)],[handles.mydata.profile_xy(1,2) handles.mydata.profile_xy(2,2)],'k','Linewidth',1.5)     
        if ny>1 % if profile thicker than 1 pixel
            rectangle('Position',[handles.mydata.crosshair_xy(1)-round(ny/2),handles.mydata.profile_xy(1,2),...
                    ny,handles.mydata.profile_xy(2,2)-handles.mydata.profile_xy(1,2)],...
                    'EdgeColor','k','LineWidth',0.5,'LineStyle','-')    
        end
    elseif strcmp(tag,'rb_horizontal')  % horizontal profile        
        plot([handles.mydata.profile_xy(1,1) handles.mydata.profile_xy(2,1)],    [handles.mydata.crosshair_xy(2) handles.mydata.crosshair_xy(2)],'k','Linewidth',1)     
        if ny>1  % if profile thicker than 1 pixel            
            rectangle('Position',[handles.mydata.profile_xy(1,1),  handles.mydata.crosshair_xy(2)-round(ny/2),...
                     handles.mydata.profile_xy(2,1)-handles.mydata.profile_xy(1,1), ny],...
                     'EdgeColor','k','LineWidth',0.5,'LineStyle','-')               
        end    
    else % if custom line          
        line(handles.mydata.profile_xy(:,1),handles.mydata.profile_xy(:,2),'Color','k','Linewidth',1);
               
    end
        plot(handles.mydata.crosshair_xy(1), handles.mydata.crosshair_xy(2), 'r+', 'LineWidth', 2, 'MarkerSize', 10);
        hold off  
    
    % profile plot (axes 2) 
    % +++++++++++++++++++++++++++++++++++++++++++++++++++++++
    axes(handles.axes2)
        set(handles.axes2,'YColor','w')
    if strcmp(tag,'rb_vertical')     % vertical profile        
        plot(squeeze(handles.mydata.y_map(handles.mydata.profile_xy(1,2):handles.mydata.profile_xy(2,2),1,:))*10^3,...
            squeeze(handles.mydata.map(handles.mydata.profile_xy(1,2):handles.mydata.profile_xy(2,2),handles.mydata.crosshair_xy(1),:))*10^6, 'Linewidth',1)
        xlim([handles.mydata.y_map(handles.mydata.profile_xy(1,2),1,1)   handles.mydata.y_map(handles.mydata.profile_xy(2,2),1,1)]*10^3)
        xlabel('y-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Figure [um]','Fontsize',12,'FontWeight','bold')  
    elseif strcmp(tag,'rb_horizontal')  % horizontal profile        
        plot(squeeze(handles.mydata.x_map(1,handles.mydata.profile_xy(1,1):handles.mydata.profile_xy(2,1),:))*10^3,...
            squeeze(handles.mydata.map(handles.mydata.crosshair_xy(2),handles.mydata.profile_xy(1,1):handles.mydata.profile_xy(2,1),:))*10^6, 'Linewidth',1) 
        xlim([handles.mydata.x_map(1,handles.mydata.profile_xy(1,1),1)   handles.mydata.x_map(1,handles.mydata.profile_xy(2,1),1) ]*10^3)
        xlabel('X-axis [mm]','Fontsize',10,'FontWeight','bold')
        ylabel('Figure [um]','Fontsize',10,'FontWeight','bold')
    else
        plot(handles.profile.x*10^3, handles.profile.height*10^6, 'Linewidth',1) 
        xlim([handles.profile.x(1)   handles.profile.x(end) ]*10^3)
        xlabel('Length [mm]','Fontsize',10,'FontWeight','bold')
        ylabel('Figure [um]','Fontsize',10,'FontWeight','bold')
    end
    
    
                               
function handles = reset_uicontrols(hObject,handles)

    % reset edit controls
    set(handles.e_profile_width,'String','');
    
    set(handles.e_crosshair_x,'String','');
    set(handles.e_crosshair_y,'String','');
    
    set(handles.e_profile_x1,'String','');
    set(handles.e_profile_x2,'String','');
    set(handles.e_profile_y1,'String','');
    set(handles.e_profile_y2,'String','');

    set(handles.e_deg_poly,'String','');
    
    % reset radiobuttons   
    set(handles.rb_horizontal,'Value',1) 
    
    % reset textboxes
    set(handles.t_optic_name,'String','---'); 
    set(handles.t_Nx_Ny,'String','--- x ---');    
    set(handles.t_W_H,'String','--- x ---');
    set(handles.t_dx_dy,'String','--- x ---');
    set(handles.t_mappy_says,'String','');    
    set(handles.t_profile_width_mm,'String','Width:           mm'); 
    set(handles.t_profile_length_mm,'String','Length:           mm'); 
    
    % Update handles structure
    guidata(hObject, handles);   
    
    

    
    
  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%%                  *** USELESS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function popupmenu1_Callback(hObject, eventdata, handles)

    
function listbox2_Callback(hObject, eventdata, handles)


function s_map_browser_Callback(hObject, eventdata, handles)
       disp('inactive')


function e_profile_width_KeyPressFcn(hObject, eventdata, handles)





% function lb_profile_names_Callback(hObject, eventdata, handles) 








function e_profile_y1_Callback(hObject, eventdata, handles)
% hObject    handle to e_profile_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_profile_y1 as text
%        str2double(get(hObject,'String')) returns contents of e_profile_y1 as a double


% --- Executes during object creation, after setting all properties.
function e_profile_y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_profile_y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function e_profile_y2_Callback(hObject, eventdata, handles)
% hObject    handle to e_profile_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_profile_y2 as text
%        str2double(get(hObject,'String')) returns contents of e_profile_y2 as a double


% --- Executes during object creation, after setting all properties.
function e_profile_y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_profile_y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
