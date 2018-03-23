function varargout = atomappy(varargin)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%  ATOMAPPY manageS SPIP maps from miniFIZ and microXAM
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                % Begin initialization code - DO NOT EDIT
                gui_Singleton = 1;
                gui_State = struct('gui_Name',       mfilename, ...
                                   'gui_Singleton',  gui_Singleton, ...
                                   'gui_OpeningFcn', @atomappy_OpeningFcn, ...
                                   'gui_OutputFcn',  @atomappy_OutputFcn, ...
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
function atomappy_OpeningFcn(hObject, eventdata, handles, varargin)

    axes(handles.axes1)
    cla
    axis off
    
    set(handles.t_Nx_Ny,'String','--- x ---')
    set(handles.t_W_H,'String','--- x ---')
    set(handles.t_dx_dy,'String','--- x ---')

    
    set(handles.e_x,'String','---')
    set(handles.e_y,'String','---')
    
    handles.pathname = 'S:\Science\Optics\Metrology Lab\Metrology Tests';
    handles.colormap = jet(256);

    % Choose default command line output for atomappy
    handles.output = hObject;
     
    % Display message
    set (handles.t_mappy_says,'String',{'MAPPY says:';'   Ready for action '})
  

    % Update handles structure
    guidata(hObject, handles);

    
% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function varargout = atomappy_OutputFcn(hObject, eventdata, handles) 

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
    
 
    
    
%% ------ MENU COLORMAP ---------------------------------------------   

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

        
        
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



%% ::::::::::::::::: CRT DATA :::::::::::::::::   


% ************   load map   ************   
function pb_load_Callback(hObject, eventdata, handles)
    pathN = handles.pathname;
    
    [fileN,pathN] = uigetfile([pathN '\*.asc'],'MultiSelect','on');    
    
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
    
    for kk = 1:numel(fileN)        
        C = readSPIPasc([pathN '\' fileN{kk}]);            
            if isempty(C)
                return
            end          
            handles.mydata.namelist{kk} = fileN{kk}(1:end-4);
            handles.mydata.map(:,:,kk) = C.data;
            [handles.mydata.x(:,:,kk) handles.mydata.y(:,:,kk)] = meshgrid(C.x, C.y);
    end
     
    a = num2str(handles.mydata.x(1,end,1)*10^3);
    if numel(a)>5
        a = a(1:5);
    end
    b = num2str(handles.mydata.y(end,1,1)*10^3);
    if numel(b)>5
        b = b(1:5);
    end
    
    set(handles.e_optic_name,'String',fileN{1});
    set(handles.t_W_H,'String',[a ' x ' b]);
    a = num2str(size(C.data,2));
    b = num2str(size(C.data,1));
    set(handles.t_Nx_Ny,'String',[a ' x ' b]);
    a = num2str((handles.mydata.x(1,2) - handles.mydata.x(1,1))*10^6);
    b = num2str((handles.mydata.y(2,1) - handles.mydata.y(1,1))*10^6);
    set(handles.t_dx_dy,'String',[a(1:5) ' x ' b(1:5)]);
    
    % set a current point
    [y,x] = size(handles.mydata.map); 
    
    x = round(x/2);
    y = round(y/2); 
    handles.mydata.crt_x = round(x);
    handles.mydata.crt_y = round(y);
    set(handles.e_x,'String',num2str(x));
    set(handles.e_y,'String',num2str(y));

    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
    

    
% ************   crop ROI from loaded map   ************     
function pb_crop_Callback(hObject, eventdata, handles)
    
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
    handles.mydata.x = handles.mydata.x(y(1):y(2),x(1):x(2),:);
    handles.mydata.x = handles.mydata.x - handles.mydata.x(1,1,1);
    handles.mydata.y = handles.mydata.y(y(1):y(2),x(1):x(2),:);
    handles.mydata.y = handles.mydata.y - handles.mydata.y(1,1,1);
    
    % save crop coordinates
    handles.mydata.crop_ind_xy = [x y];       
    a = num2str(handles.mydata.x(1,end,1)*10^3);
    b = num2str(handles.mydata.y(end,1,1)*10^3);
    set(handles.t_W_H,'String',[a(1:5) ' x ' b(1:5)]);
    a = num2str(size(handles.mydata.map,2));
    b = num2str(size(handles.mydata.map,1));
    set(handles.t_Nx_Ny,'String',[a ' x ' b]);
    a = num2str((handles.mydata.x(1,2,1)-handles.mydata.x(1,1,1))*10^6);
    b = num2str((handles.mydata.y(2,1,1)-handles.mydata.y(1,1,1))*10^6);
    set(handles.t_dx_dy,'String',[a(1:5) ' x ' b(1:5)]);
    
    % set a current point
    [y,x,z] = size(handles.mydata.map); 
    
    x = round(x/2);
    y = round(y/2); 
    handles.mydata.crt_x = round(x);
    handles.mydata.crt_y = round(y);   

    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
     
    
% ************   save data    ************  
function pb_save_Callback(hObject, eventdata, handles)    
    disp('Not just yet')    
    
    

function e_optic_name_Callback(hObject, eventdata, handles)
   handles.mydata.optic_name = get(hObject,'String');
   
   % Update handles structure
    guidata(hObject, handles);
    
    
    
    
%% ::::::::::::::::: POP OUT FIGURE :::::::::::::::::   


% *********   select display mode in outer figure 123     ************    
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
    
  if get(handles.rb_mesh,'Value')==1
            x = handles.mydata.x(1:4:end,1:4:end)*10^3;
            y = handles.mydata.y(1:4:end,1:4:end)*10^3;
            map = handles.mydata.map(1:4:end,1:4:end)*10^9;     
            
            mesh(handles.mydata.x(1:4:end,1:4:end)*10^3,handles.mydata.y(1:4:end,1:4:end)*10^3,handles.mydata.map(1:4:end,1:4:end)*10^9), %axis equal
            colormap(handles.colormap)
            xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
            ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold') 
            zlabel('Z-axis [nm]','Fontsize',12,'FontWeight','bold')      
  elseif get(handles.rb_surf,'Value')==1
            x = handles.mydata.x(1:4:end,1:4:end)*10^3;
            y = handles.mydata.y(1:4:end,1:4:end)*10^3;
            map = handles.mydata.map(1:4:end,1:4:end)*10^9;                                                 
            minZ = min(map(:));  %# Find minimum value of Z
            maxZ = max(map(:));  %# Find maximum value of Z  
            surf(x,y,map, 'LineStyle', 'none', 'FaceColor', 'interp')
            colormap(jet)
            camlight right

            xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
            ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold') 
            zlabel('Z-axis [nm]','Fontsize',12,'FontWeight','bold') 
            
  elseif get(handles.rb_image,'Value')==1
            
            imagesc(handles.mydata.map(:,:,1)),  axis off
            colormap(handles.colormap)
  else
            x = handles.mydata.x(1:4:end,1:4:end)*10^3;
            y = handles.mydata.y(1:4:end,1:4:end)*10^3;
            map = handles.mydata.map(1:4:end,1:4:end)*10^9;     
            
            
            colormap(handles.colormap),
            plot3(x(:),y(:),map(:),'k.')
            xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
            ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold') 
            zlabel('Z-axis [nm]','Fontsize',12,'FontWeight','bold')       
      
  end
   
  
  
  
    
%% ::::::::::::::::: POP OUT PROFILE  :::::::::::::::::  


% ************   choose horizontal or vertical profile   ************     
function rbp_horiz_vert_SelectionChangeFcn(hObject, eventdata, handles)
    handles = refresh_axes(handles);
    

    
% ************   pick point in map for profile   ************   
function pb_pick_profile_Callback(hObject, eventdata, handles)
    
    figure(234),set(gcf,'color','w',  'Position', [100, 100, 700, 500]);
    imagesc(handles.mydata.map(:,:,1))
    colormap(handles.colormap)
    [x,y] = ginput(1);    
    close(234)
 
    handles.mydata.crt_x = round(x);
    handles.mydata.crt_y = round(y);    
    set(handles.e_x,'String',num2str(round(x)));
    set(handles.e_y,'String',num2str(round(y)));  
    
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
    
    
% ************   set profile point at centre of the 2d map   ************      
function pb_centred_profile_Callback(hObject, eventdata, handles) 
    
    [y,x,z] = size(handles.mydata.map)     
    x = round(x/2);
    y = round(y/2);       
    
    handles.mydata.crt_x = x;
    handles.mydata.crt_y = y;
    
    set(handles.e_x,'String',num2str(x));
    set(handles.e_y,'String',num2str(y));
   
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);    
     
    
% ************   set x coordinate for profile    ************   
function e_x_Callback(hObject, eventdata, handles) %#ok<*DEFNU,*INUSL>
    x = str2num(get(hObject,'String')); %#ok<ST%#ok<*MSNU> 2NM>
    x = round(x);
    if x<=size(handles.mydata.map,2)
        handles.mydata.crt_x = x;        
    else
        set(hObject,'String',num2str(handles.mydata.crt_x))
    end
    
    handles = refresh_axes(handles);

    % Update handles structure
    guidata(hObject, handles);
    
    
% ************   set y coordinate for profile    ************   
function e_y_Callback(hObject, eventdata, handles)
    y = str2num(get(handles.e_y,'String')); %#ok<*ST2NM>
    y = round(y);
    if y<=size(handles.mydata.map,1)
        handles.mydata.crt_y = y;
    else
        set(hObject,'String',num2str(handles.mydata.crt_y))
    end
    
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);
     
   
% ************   pop out 1D profile    ************  
function pb_pop_out_profile_Callback(hObject, eventdata, handles)

    figure(456),set(gcf,'color','w',  'Position', [100, 100, 700, 400]);        
    if strcmp(get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag'),'rb_horizontal')       
        y = handles.mydata.crt_y;            
        plot(handles.mydata.x(y,:)*10^3,handles.mydata.map(y,:)*10^6,'Linewidth',2)
        colormap(handles.colormap)
        xlim([0 handles.mydata.x(end)]*10^3)
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Z-axis [mm]','Fontsize',12,'FontWeight','bold')
        title('Horizontal profile','Fontsize',14,'FontWeight','bold') 
    elseif strcmp(get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag'),'rb_vertical')  
        x = handles.mydata.crt_x;
        plot(handles.mydata.y(:,x)*10^3,handles.mydata.map(:,x)*10^6,'Linewidth',2)            
        xlim([0 handles.mydata.y(end)]*10^3)
        colormap(handles.colormap)
        xlabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Z-axis [um]','Fontsize',12,'FontWeight','bold')
        title('Vertical profile','Fontsize',14,'FontWeight','bold') 
    end        

    % Update handles structure
    guidata(hObject, handles);


    
 
% ************   fit profile to polynomial    ************       
function pb_polyfit_Callback(hObject, eventdata, handles)
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    deg = str2num(get(handles.e_deg_poly,'String'));
    data = handles.mydata.map(:,:,1);
    ny = str2num(get(handles.e_Npix,'String'));
    
    if strcmp(tag,'rb_horizontal')
        yc = handles.mydata.crt_y;        
        x = handles.mydata.x(yc,:,1);
        height = squeeze(mean(data(round(yc-ny/2):round(yc+ny/2),:),1));
    else        
        yc = handles.mydata.crt_x;
        x = handles.mydata.y(:,yc,1)';
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

 

% ************   fit profile to cylinder    ************  
function pb_NOMfit_Callback(hObject, eventdata, handles)
% only analyses the first map    
    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    ny = str2num(get(handles.e_Npix,'String'));
    data = handles.mydata.map(:,:,1);
    
    if strcmp(tag,'rb_horizontal')   
        yc = handles.mydata.crt_y;
        x = handles.mydata.x(yc,:,1);
        dx = x(2)-x(1);
        height = squeeze(mean(data(round(yc-ny/2):round(yc+ny/2),:),1));
    else% vertical line
        yc = handles.mydata.crt_x;
        x = handles.mydata.y(:,yc,1)';
        dx = x(2)-x(1);
        height = squeeze(mean(data(:,round(yc-ny/2):round(yc+ny/2)),2))';
    end
    height = height-mean(height);
    slope = diff(height)./diff(x);
    handles.profile = fitnom(x(1:end-1)',slope','cylinder',[]);

    handles.profile.height = height;
    handles.profile.xlin = x;
    handles.profile.slope = slope;
    
    % Update handles structure
    guidata(hObject, handles);
    
% ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  

    
 % ************  TRIAL function    ************   
function pb_joker_Callback(hObject, eventdata, handles)
    
   
    
    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** INBUILT FUNCTIONS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function handles = refresh_axes(handles)
    if ~isfield(handles,'mydata')    
        return
    end    

    tag = get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag');
    axes(handles.axes1)
            imagesc(handles.mydata.map(:,:,1)),axis image,axis off
            hold on
            
    if strcmp(tag,'rb_vertical')        
            plot([handles.mydata.crt_x handles.mydata.crt_x],[1 size(handles.mydata.map,1)],'k','Linewidth',1)            
            hold off
    else  %horizontal plot
            plot([1 size(handles.mydata.map,2)],[handles.mydata.crt_y handles.mydata.crt_y],'k','Linewidth',1)           
            hold off
    end
                               
