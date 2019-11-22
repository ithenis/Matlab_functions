function varargout = supersmith(varargin)

                    % Begin initialization code - DO NOT EDIT
                    gui_Singleton = 1;
                    gui_State = struct('gui_Name',       mfilename, ...
                                       'gui_Singleton',  gui_Singleton, ...
                                       'gui_OpeningFcn', @supersmith_OpeningFcn, ...
                                       'gui_OutputFcn',  @supersmith_OutputFcn, ...
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

% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% --- Executes just before supersmith is made visible.
function supersmith_OpeningFcn(hObject, eventdata, handles, varargin)

    % initialise variables
    handles = reset_variables(hObject, handles);
    
    % Reset uicontrols
    handles = reset_uicontrols(hObject,handles);
   
    % Display
      
    pathN = mfilename('fullpath');
    % 'C:\Users\elt29493\Documents\MATLAB\_function_library\GUIs\supersmith'
    pathN = pathN(1:end-length('supersmith')); 
    
    a = imread([pathN 'supersmith.jpg']);
    axes(handles.axes1)
    imagesc(a),axis off, axis equal
    
    set(handles.t_smith_says,'String',{'Agent Smith says:';'   Good morning, Mr Anderson'}) 
        
    % Choose default command line output for supersmith
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  


% --- Outputs from this function are returned to the command line.
function varargout = supersmith_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  




% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%      *** MENU CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
%% ------ MENU GENERAL ---------------------------------------------
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  



% *** clear variables from  workkspace  *** 
function m_clear_Callback(hObject, eventdata, handles)
    evalin('base','clear')
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++      
    
    
% *** clear command panel  ***     
function m_clc_Callback(hObject, eventdata, handles)
    evalin('base','clc')
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
    


% *** send handles to workspace  *** 
function m_handles2base_Callback(hObject, eventdata, handles)
    assignin('base','handles',handles);    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   

    
% *** send mydata to workspace  *** 
function m_mydata2base_Callback(hObject, eventdata, handles)    
    assignin('base','mydata',handles.mydata);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++      
 
     
    
% *** send exploded datasets to workspace  *** 
function m_datasets2base_Callback(hObject, eventdata, handles)
    assignin('base','mydata',handles.mydata);
    evalin('base','structxplode(mydata)')
    evalin('base','datasets = datasets(active_sets);')
    evalin('base','set_names = set_names(active_sets);')
    evalin('base','keep datasets set_names')
    evalin('base','for kk = 1:numel(datasets), set_names{kk} = datasets{1,kk}; end')
    
    
    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
% --------------------------------------------------------------------
%% ----------------- ALL SETS ----------------------------------------
% --------------------------------------------------------------------
% --------------------------------------------------------------------
    


% ************   load datasets from mat file  ************
function pb_load_all_Callback(hObject, eventdata, handles) 

    pathN = handles.pathname; 
    
    [fileN,pathN] = uigetfile([pathN '\*.mat']);
    if fileN == 0           
        disp('user abort')
        return
    end  
    load([pathN fileN]);
    handles.pathname = pathN;
    
    handles = pb_clear_all_Callback(hObject, eventdata, handles);
    
    
    if exist('flip_flag','var')   % 2nd revision
        
        handles.mydata = load([pathN fileN]);        
        
        if size(handles.mydata.fitted_flag,2)==9
            handles.mydata.datasets{1,10} = [];
            handles.mydata.datasets{1,11} = [];
            handles.mydata.datasets{1,12} = [];
            handles.mydata.fitted_flag(:,10:12) = 0;
            handles.mydata.flip_flag(1,10:12) = 0;
            handles.mydata.mavg_flag(1,10:12) = 0;
            handles.mydata.plot_flag(1,10:12) = 0;
            handles.mydata.x_offset(1,10:12) = 0;
            handles.mydata.scan_file_names{10} = [];
            handles.mydata.scan_file_names{11} = [];
            handles.mydata.scan_file_names{12} = [];
            handles.mydata.set_names{10} = [];      
            handles.mydata.set_names{11} = [];  
            handles.mydata.set_names{12} = [];  
        end
        
        
        
        set(handles.e_name,'String',handles.mydata.set_names{handles.mydata.crt_set});
    else
        
        
        if exist('datasets','var')    
            output = cellfun(@(x) isstruct(x), handles.mydata.datasets);
            handles.mydata.active_sets = find(output);
            
        else    % old version (maybe I should get rid of this)
           return
        end
        % set missing variables
        handles.mydata.active_sets = unique(handles.mydata.active_sets);
        handles.mydata.crt_set = 1;
        handles.mydata.flip_flag(handles.mydata.active_sets) = 0;
        handles.mydata.plot_flag(handles.mydata.active_sets) = 1;
        handles.mydata.x_offset(handles.mydata.active_sets) = 0;
        handles.mydata.x_offset(handles.mydata.active_sets) = 0;
        
        handles.mydata.scan_file_names(handles.mydata.active_sets) = cellfun(@(x) x.namelist{1}, handles.mydata.datasets(handles.mydata.active_sets), 'UniformOutput', false);
        
        handles.pathname = pathN;        
       
    end
    
    
    handles.pathname = pathN;   
    % refresh display
    set(handles.cb_flip,'Value',handles.mydata.flip_flag(handles.mydata.crt_set));
    set(handles.cb_plot,'Value',handles.mydata.plot_flag(handles.mydata.crt_set));       
    set(handles.e_offset_x,'String',num2str(handles.mydata.x_offset(handles.mydata.crt_set)*10^3));
    set(handles.e_name,'String',handles.mydata.set_names{handles.mydata.crt_set});
    set(handles.t_scan_file_name,'String',{'Scan file name:'; handles.mydata.scan_file_names{handles.mydata.crt_set}});
   
        default_string = get(handles.lb_loaded_datasets,'UserData');   
        default_string(handles.mydata.active_sets) = cellfun(@(x) char(x(1:3)), default_string(handles.mydata.active_sets), 'UniformOutput', false);
    set(handles.lb_loaded_datasets,'String',strcat(default_string,handles.mydata.set_names));
    
% Update handles structure
guidata(hObject, handles);   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    

    
% ************   clear mydata  ************
function handles = pb_clear_all_Callback(hObject, eventdata, handles)
    
    handles = reset_uicontrols(hObject,handles);
    handles = reset_variables(hObject, handles);   

    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% ************   save all datasets to mat file  ************
function pb_save_all_Callback(hObject, eventdata, handles)
    
    evalin('base','clear') 
    
    pathN = handles.pathname;   
    [fileN,pathN] = uiputfile([pathN '\*.mat']);
    if fileN == 0           
        disp('user abort')
        return
    end 
    
    filename = [pathN fileN];
   
    assignin('base','mydata',handles.mydata);
    evalin('base',['structxplode(mydata)']) 
    evalin('base',['clear mydata']) 
    evalin('base',['save(''' [filename(1:end-4) '__SS-full.mat'] ''')']) 
    handles.pathname = pathN;
    
    % Update handles structure
    guidata(hObject, handles);  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    



% --- Executes on button press in pb_sort_all.
function pb_sort_all_Callback(hObject, eventdata, handles)
%     handles.mydata.active_sets
    bb = handles.mydata.set_names';
    aa = Sorter(handles.mydata.set_names);
    empties = setdiff(1:12,handles.mydata.active_sets); 
    kk = 1;
    new_active = [];   switch_map = [];
    for ii = 1:size(aa,2)       
    
        % this isn't working properly
        if ~isempty(aa{ii})
            switch_map = [switch_map; find(strcmp(handles.mydata.set_names, aa{ii}))];
            new_active = [new_active; ii];
        else
            switch_map = [switch_map; empties(kk)];
            kk = kk+1;
        end
        
        
    end
    switch_map
    new_active
    old_active = handles.mydata.active_sets;
     
    % reorder things (if you can...)
    % ----------------------------------------------------------------

    handles.mydata.set_names = aa';
    handles.mydata.active_sets = new_active';
    default_string = get(handles.lb_loaded_datasets,'UserData');    
    default_string(handles.mydata.active_sets) = cellfun(@(x) char(x(1:3)), default_string(handles.mydata.active_sets), 'UniformOutput', false);
    set(handles.lb_loaded_datasets,'String',strcat(default_string,handles.mydata.set_names));
    handles.mydata.crt_set = 1;
    handles.mydata.active_sets = new_active';
    

    
    handles.mydata.datasets = handles.mydata.datasets(switch_map);
    handles.mydata.plot_flag = handles.mydata.plot_flag(switch_map);  
    handles.mydata.flip_flag = handles.mydata.flip_flag(switch_map);
    handles.mydata.x_offset = handles.mydata.x_offset(switch_map);  
    
    handles.mydata.fitted_flag = handles.mydata.fitted_flag(switch_map);
    handles.mydata.mavg_flag = handles.mydata.mavg_flag(switch_map);
    
    
    % Update handles structure
    guidata(hObject, handles);    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++      


function pb_Mavg_Callback(hObject, eventdata, handles)
    aa = smoothie(handles.mydata.datasets{handles.mydata.crt_set});
       
    handles.mydata.datasets{handles.mydata.crt_set} = aa;
    
   
        
    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++      
     
    
    
    
% --------------------------------------------------------------------
%% --------- Current DATASET  ----------------------------------------  
% --------------------------------------------------------------------
% --------------------------------------------------------------------
    


% ************   load data from workspace  ************
function pb_load_dataset_from_workspace_Callback(hObject, eventdata, handles) 

    % pas de gardefou!! load EVERYTHING from base workspace. 
    handles.mydata.datasets{handles.mydata.crt_set} = struct;
    evalin('base','save dummy');
    handles.mydata.datasets{handles.mydata.crt_set} = load('dummy.mat');  
    delete('dummy.mat');
    
    % set variables    
    handles.mydata.set_names{handles.mydata.crt_set} = handles.mydata.datasets{handles.mydata.crt_set}.namelist{1}; 
    handles.mydata.scan_file_names{handles.mydata.crt_set} = handles.mydata.datasets{handles.mydata.crt_set}.namelist{1}; 
    handles.mydata.active_sets = sort([handles.mydata.active_sets handles.mydata.crt_set]);   
    handles.mydata.active_sets = unique(handles.mydata.active_sets);
    handles.mydata.flip_flag(handles.mydata.crt_set) = 0; 
    handles.mydata.plot_flag(handles.mydata.crt_set) = 1;
    
    if isfield(handles.mydata.datasets{handles.mydata.crt_set},'fitted')
        if isfield(handles.mydata.datasets{handles.mydata.crt_set}.fitted,'slope_err')
            handles.mydata.fitted_flag(1,handles.mydata.crt_set) = 1;
        end
        if isfield(handles.mydata.datasets{handles.mydata.crt_set}.fitted,'height_err')
            handles.mydata.fitted_flag(2,handles.mydata.crt_set) = 1;
        end
        if isfield(handles.mydata.datasets{handles.mydata.crt_set}.fitted,'active_height')
            handles.mydata.fitted_flag(3,handles.mydata.crt_set) = 1;
        end
    end
    
    if isfield(handles.mydata.datasets{handles.mydata.crt_set},'mavg')
        handles.mydata.mavg_flag(handles.mydata.crt_set) = 1;
    end
    handles.mydata.x_offset(handles.mydata.crt_set) = 0;     
    
    % set uicontrols
    set(handles.cb_flip,'Value',0);
    set(handles.cb_plot,'Value',1);    
    set(handles.e_name,'String',handles.mydata.set_names{handles.mydata.crt_set});    
        default_string = get(handles.lb_loaded_datasets,'UserData');   
        default_string(handles.mydata.active_sets) = cellfun(@(x) char(x(1:3)), default_string(handles.mydata.active_sets), 'UniformOutput', false);
    set(handles.lb_loaded_datasets,'String',strcat(default_string,handles.mydata.set_names));
    
    % Update handles structure
    guidata(hObject, handles);    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    

% ************   load data from mat file  ************
function pb_load_dataset_from_file_Callback(hObject, eventdata, handles)
    disp('not updated!!!')
    return
    % load data
    pathN = handles.pathname;   
    [fileN,pathN] = uigetfile([pathN '\*.mat']);
    if fileN == 0           
        disp('user abort')
        return
    end 
    handles.pathname = pathN;
    
    handles.mydata.datasets{handles.mydata.crt_set} = struct;    
    load([pathN fileN])
    handles.mydata.datasets{handles.mydata.crt_set} = datasets{1};
    
    % set variables    
    handles.mydata.set_names{handles.mydata.crt_set} = handles.mydata.datasets{handles.mydata.crt_set}.namelist{1}; 
    handles.mydata.active_sets = sort([handles.mydata.active_sets handles.mydata.crt_set]);  
    handles.mydata.active_sets = unique(handles.mydata.active_sets);
    handles.mydata.flip_flag(handles.mydata.crt_set) = 0; 
    handles.mydata.plot_flag(handles.mydata.crt_set) = 1;
    handles.mydata.x_offset(handles.mydata.crt_set) = 0;     
    
    % set uicontrols
    set(handles.cb_flip,'Value',0);
    set(handles.cb_plot,'Value',1);    
    set(handles.e_name,'String',handles.mydata.set_names{handles.mydata.crt_set});    
        default_string = get(handles.lb_loaded_datasets,'UserData');   
        default_string(handles.mydata.active_sets) = cellfun(@(x) char(x(1:3)), default_string(handles.mydata.active_sets), 'UniformOutput', false);
        
    set(handles.lb_loaded_datasets,'String',strcat(default_string, handles.mydata.set_names));
        
    handles.pathname = pathN; 
    
    % Update handles structure
    guidata(hObject, handles);      
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  



% ************   Save one dataset  ************
function pb_save_dataset_Callback(hObject, eventdata, handles)

    evalin('base','clear') 
%     
    pathN = handles.pathname;   
    [fileN,pathN] = uiputfile([pathN '\*.mat']);
    if fileN == 0           
        disp('user abort')
        return
    end 
    
    filename = [pathN fileN];
   
    assignin('base','dataset',handles.mydata.datasets{handles.mydata.crt_set});
    evalin('base','structxplode(dataset)') 
    
    evalin('base','ss_vars = struct')
    
    assignin('base','set_name',handles.mydata.set_names{handles.mydata.crt_set});
    evalin('base','ss_vars.set_name = set_name;');
    evalin('base','clear set_name');
    
    assignin('base','scan_file_name', handles.mydata.scan_file_names{handles.mydata.crt_set}); 
    evalin('base','ss_vars.scan_file_name = scan_file_name;');
    evalin('base','clear scan_file_name');
    
    assignin('base','flip_flag', handles.mydata.flip_flag(handles.mydata.crt_set)); 
    evalin('base','ss_vars.flip_flag = flip_flag;');
    evalin('base','clear flip_flag');
    
    assignin('base','plot_flag', handles.mydata.plot_flag(handles.mydata.crt_set));
    evalin('base','ss_vars.plot_flag = plot_flag;');
    evalin('base','clear plot_flag');
    
    assignin('base','fitted_flag', handles.mydata.fitted_flag(:,handles.mydata.crt_set));
    evalin('base','ss_vars.fitted_flag = fitted_flag;');
    evalin('base','clear fitted_flag');
    
    assignin('base','mavg_flag', handles.mydata.fitted_flag(handles.mydata.crt_set));
    evalin('base','ss_vars.mavg_flag = mavg_flag;');
    evalin('base','clear mavg_flag');
    
    
    
    assignin('base','x_offset', handles.mydata.x_offset(handles.mydata.crt_set));
    evalin('base','ss_vars.x_offset = x_offset;');
    evalin('base','clear x_offset');
    
   
    evalin('base',['save(''' [filename(1:end-4) '__SS-dataset.mat'] ''')']) 
    handles.pathname = pathN;
    
    % Update handles structure
    guidata(hObject, handles);


    
% ************   Clear one dataset  ************
function pb_clear_dataset_Callback(hObject, eventdata, handles)

    % set variables   
    handles.mydata.datasets{handles.mydata.crt_set} = [];
    handles.mydata.set_names{handles.mydata.crt_set} = [];
    
    handles.mydata.flip_flag(handles.mydata.crt_set) = 0; 
    handles.mydata.plot_flag(handles.mydata.crt_set) = 0;
    handles.mydata.x_offset(handles.mydata.crt_set) = 0; 
    
    handles.mydata.fitted_flag(:,handles.mydata.crt_set) = 0;
    handles.mydata.fitted_flag(handles.mydata.crt_set) = 0;
    
    output = cellfun(@(x) isstruct(x), handles.mydata.datasets);   
    handles.mydata.active_sets = find(output); 
    
    
    % set uicontrols
    set(handles.cb_flip,'Value',0);
    set(handles.cb_plot,'Value',0);    
    
    set(handles.e_offset_x,'String','');   
    set(handles.e_name,'String',handles.mydata.set_names{handles.mydata.crt_set});    
        default_string = get(handles.lb_loaded_datasets,'UserData');   
        default_string(handles.mydata.active_sets) = cellfun(@(x) char(x(1:3)), default_string(handles.mydata.active_sets), 'UniformOutput', false);
    set(handles.lb_loaded_datasets,'String',strcat(default_string,handles.mydata.set_names));
    
    % Update handles structure
    guidata(hObject, handles);  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  



% ************   Edit dataset name  ************
function e_name_Callback(hObject, eventdata, handles)
 
   handles.mydata.set_names{handles.mydata.crt_set} = get(hObject,'String');     
   default_string = get(handles.lb_loaded_datasets,'UserData');   
   default_string(handles.mydata.active_sets) = cellfun(@(x) char(x(1:3)), default_string(handles.mydata.active_sets), 'UniformOutput', false);   set(handles.lb_loaded_datasets,'String',strcat(default_string, handles.mydata.set_names));
    

    % Update handles structure
    guidata(hObject, handles);     
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    


    
% ************   Flip dataset left to right  ************
function cb_flip_Callback(hObject, eventdata, handles)
    
    val = get(hObject,'Value');
   if isempty(fieldnames(handles.mydata.datasets{handles.mydata.crt_set}))
        set(hObject,'Value',0)
        return
    else
        handles.mydata.flip_flag(handles.mydata.crt_set) = val; 
        handles.mydata.datasets{handles.mydata.crt_set}.slope_err = flipud(-handles.mydata.datasets{handles.mydata.crt_set}.slope_err);
        handles.mydata.datasets{handles.mydata.crt_set}.active_height = flipud(handles.mydata.datasets{handles.mydata.crt_set}.active_height);
        handles.mydata.datasets{handles.mydata.crt_set}.height_err = flipud(handles.mydata.datasets{handles.mydata.crt_set}.height_err);
        handles.mydata.datasets{handles.mydata.crt_set}.active_phi_roll = flipud(-handles.mydata.datasets{handles.mydata.crt_set}.active_phi_roll);
        
        
        if isfield(handles.mydata.datasets{handles.mydata.crt_set},'fitted')
            if isfield(handles.mydata.datasets{handles.mydata.crt_set}.fitted,'slope_err')
                handles.mydata.datasets{handles.mydata.crt_set}.fitted.slope_err = flipud(-handles.mydata.datasets{handles.mydata.crt_set}.fitted.slope_err);
            end 
            if isfield(handles.mydata.datasets{handles.mydata.crt_set}.fitted,'height_err')
                handles.mydata.datasets{handles.mydata.crt_set}.fitted.height_err = flipud(handles.mydata.datasets{handles.mydata.crt_set}.fitted.height_err);
            end     
            if isfield(handles.mydata.datasets{handles.mydata.crt_set}.fitted,'active_height')
                handles.mydata.datasets{handles.mydata.crt_set}.fitted.active_height = flipud(-handles.mydata.datasets{handles.mydata.crt_set}.fitted.active_height);
            end     
                
        end
        
        handles.mydata.flip_flag(handles.mydata.crt_set) = val; 
    end         

    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++     
 


% ************   Plot or not dataset  ************    
function cb_plot_Callback(hObject, eventdata, handles)    
    
    val = get(hObject,'Value');
    if isempty(fieldnames(handles.mydata.datasets{handles.mydata.crt_set}))
        set(hObject,'Value',0)
        return
    else
        handles.mydata.plot_flag(handles.mydata.crt_set) = val;
    end         
       
    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++        



% ************   Set an x offset. this is an absolute value. not relative  ************      
function e_offset_x_Callback(hObject, eventdata, handles)    

    val = str2num(get(hObject,'String'))*10^-3;    
    if isempty(fieldnames(handles.mydata.datasets{handles.mydata.crt_set}))
        set(hObject,'String','0')
        return
    end
    if handles.mydata.x_offset(handles.mydata.crt_set) ~= val; 
        handles.mydata.datasets{handles.mydata.crt_set}.active_x = handles.mydata.datasets{handles.mydata.crt_set}.active_x...
            -handles.mydata.x_offset(handles.mydata.crt_set) + val;
        handles.mydata.x_offset(handles.mydata.crt_set) = val; 
      
    end         
       
    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    


% --------------------------------------------------------------------
%% ----------------   DISPLAY  ---------------------------------------
% --------------------------------------------------------------------
% --------------------------------------------------------------------



function pb_PLOT_Callback(hObject, eventdata, handles)
   
    if sum(handles.mydata.plot_flag) ==0
        return
    end
    
    
% 111.   PLOT FIGURE vs x coordinates
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    if get(handles.cb_plot_figure,'Value')    
        if ~ishandle(111)            
            figure(111),   
            set(gcf,'color','w', 'Position', [50, 50, 1100, 400],'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(111)            
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end   
        
        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                hold on
                
                if handles.mydata.fitted_flag(1,handles.mydata.active_sets(kk)) &&  get(handles.rb_plot_fitted, 'Value')                
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.fitted.active_height*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)}, 'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)                
                else
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_height*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                end
            end
            end
            hold off        
            xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
            ylabel('Figure [um]','Fontsize',12,'FontWeight','bold')
            l = legend('show');  set(l,'Interpreter', 'none','Location','best')            
        
    end    
    drawnow
    
    
% 112.  PLOT FIGURE ERROR  vs x coordinates
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    if get(handles.cb_plot_figure_err,'Value')    
        if ~ishandle(112)
            figure(112),   
            set(gcf,'color','w', 'Position', [50, 100, 1100, 400],'DefaultAxesColorOrder',handles.mydata.colormap);
            box on        
        else
            figure(112)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end          
        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                hold on
                if handles.mydata.fitted_flag(2,handles.mydata.active_sets(kk))  && get(handles.rb_plot_fitted, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.fitted.height_err*10^9,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                elseif isfield(handles.mydata.datasets{handles.mydata.active_sets(kk)},'mavg') && get(handles.rb_plot_mavg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.height_err_smooth*10^9,...
                        'DisplayName',[handles.mydata.set_names{handles.mydata.active_sets(kk)} '___m.avg' num2str(handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.span) 'pts'],...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                
                elseif get(handles.rb_plot_avg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.height_err*10^9,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)       
                
                else
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.height_err*10^9,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)                    
                end                
            end
        end
        hold off
        xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Figure error [nm]','Fontsize',12,'FontWeight','bold')
        l = legend('show');  set(l,'Interpreter', 'none','Location','best')
            
    end
    drawnow
    
    
% 113.   PLOT SLOPE ERROR  vs x coordinates
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
      if get(handles.cb_plot_slope_err,'Value')    
        if ~ishandle(113)
            figure(113),   set(gcf,'color','w',  'Position', [150, 100, 1100, 400]); 
            set(gcf,'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(113)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end
        
        for kk = 1:numel(handles.mydata.active_sets)           
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                hold on
                if handles.mydata.fitted_flag(1,handles.mydata.active_sets(kk)) &&  get(handles.rb_plot_fitted, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.fitted.slope_err*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                elseif isfield(handles.mydata.datasets{handles.mydata.active_sets(kk)},'mavg')&& get(handles.rb_plot_mavg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.slope_err_smooth*10^6,...
                        'DisplayName',[handles.mydata.set_names{handles.mydata.active_sets(kk)} '___m.avg' num2str(handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.span) 'pts'],...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)    
                elseif get(handles.rb_plot_avg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.slope_err*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)
                else
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.slope_err*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)
                end
            end
            end
            hold off
            xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
            ylabel('Slope error [urad]','Fontsize',12,'FontWeight','bold')
            l = legend('show');  set(l,'Interpreter', 'none','Location','best')
        
      end
    drawnow
    
    
% 114.   PLOT TWIST ANGLE  vs x coordinates
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if get(handles.cb_plot_twist_angle,'Value')    
        if ~ishandle(114)
            figure(114),   
            set(gcf,'color','w', 'Position', [100, 50, 1100, 400],'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(114)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end
        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                hold on
                plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                    (handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi_roll - mean(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi_roll))*10^6,...
                    'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2) 
            end            
        end
        hold off
        xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Twist angle [urad]','Fontsize',12,'FontWeight','bold') 
        l = legend('show');  set(l,'Interpreter', 'none','Location','best')
    end    
    drawnow
     
    


% 115.   PLOT SLOPE vs x coordinates
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     if get(handles.cb_plot_slope,'Value')    
            if ~ishandle(115)
                figure(115),   set(gcf,'color','w',  'Position', [200, 50, 1100, 400],'DefaultAxesColorOrder',handles.mydata.colormap);  
                set(gcf,'DefaultAxesColorOrder',handles.mydata.colormap);
                box on
            else
                figure(115)
                if get(handles.rb_new_plot,'Value')
                    hold on
                end
            end
            for kk = 1:numel(handles.mydata.active_sets)
                if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                    hold on                  
                        dphi = diff(handles.mydata.datasets{handles.mydata.active_sets(kk)}.slope_err)./...
                               diff(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x);
                        plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x*10^3,...
                             handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^3,...
                             'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                             'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)                         
                end            
            end
            hold off
            xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
            ylabel('Slope error  [urad]','Fontsize',12,'FontWeight','bold') 
            l = legend('show');  set(l,'Interpreter', 'none','Location','best')
     end    
     drawnow     
     
     
     
     
% 121.   PLOT SLOPE ERROR vs  SLOPE
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    if get(handles.cb_plot_slope_err_vs_slope,'Value')
        if ~ishandle(121)
            figure(121),
            set(gcf,'color','w', 'Position', [100, 100, 1100, 400],'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(121)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end

        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                
                hold on
                if handles.mydata.fitted_flag(1,handles.mydata.active_sets(kk)) &&  get(handles.rb_plot_fitted, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.fitted.slope_err*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                elseif isfield(handles.mydata.datasets{handles.mydata.active_sets(kk)},'mavg')&& get(handles.rb_plot_mavg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.slope_err_smooth*10^6,...
                        'DisplayName',[handles.mydata.set_names{handles.mydata.active_sets(kk)} '___m.avg' num2str(handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.span) 'pts'],...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                elseif get(handles.rb_plot_avg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.slope_err*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)
                else
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.slope_err*10^6,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)
                end
            end
        end
        hold off
        xlabel('Slope [urad]','Fontsize',12,'FontWeight','bold')
        ylabel('Slope error [urad]','Fontsize',12,'FontWeight','bold')
        l = legend('show');  set(l,'Interpreter', 'none','Location','best')
    end
    drawnow
     
  
     
% PLOT FIGURE ERROR vs  SLOPE
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    if get(handles.cb_plot_figure_err_vs_slope,'Value')    
        if ~ishandle(122)
            figure(122),   set(gcf,'color','w',  'Position', [50, 200, 1100, 400]);   
            set(gcf,'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(122)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end          
        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                
                hold on
                if handles.mydata.fitted_flag(2,handles.mydata.active_sets(kk))  && get(handles.rb_plot_fitted, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.fitted.height_err*10^9,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                elseif isfield(handles.mydata.datasets{handles.mydata.active_sets(kk)},'mavg') && get(handles.rb_plot_mavg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.height_err_smooth*10^9,...
                        'DisplayName',[handles.mydata.set_names{handles.mydata.active_sets(kk)} '___m.avg' num2str(handles.mydata.datasets{handles.mydata.active_sets(kk)}.mavg.span) 'pts'],...
                        'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),   'LineWidth',2)
                elseif get(handles.rb_plot_avg, 'Value')
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.averaged.height_err*10^9,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)
                else
                    plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                        handles.mydata.datasets{handles.mydata.active_sets(kk)}.height_err*10^9,...
                        'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2)
                end
            end
        end
        hold off
        xlabel('Slope [urad]','Fontsize',12,'FontWeight','bold')
        ylabel('Figure error [nm]','Fontsize',12,'FontWeight','bold')  
        l = legend('show');  set(l,'Interpreter', 'none','Location','best')
    end    
    drawnow     
     
    

     
% PLOT TWIST ANGLE vs  SLOPE
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    if get(handles.cb_plot_twist_vs_slope,'Value')    
        if ~ishandle(123)
            figure(123),   
            set(gcf,'color','w', 'Position', [100, 50, 1100, 400],'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(123)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end
        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                hold on
                plot(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi*10^6,...
                    (handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi_roll - mean(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi_roll))*10^6,...
                    'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:),'LineWidth',2) 
            end            
        end
        hold off
        xlabel('Slope [urad]','Fontsize',12,'FontWeight','bold')
        ylabel('Twist angle [urad]','Fontsize',12,'FontWeight','bold') 
        l = legend('show');  set(l,'Interpreter', 'none','Location','best')
    end    
    drawnow
     
     
    
% PLOT FFT SLOPE ERROR vs X
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if get(handles.cb_plot_FFT_slope_err_vs_x,'Value')
        if ~ishandle(131)
            figure(131),   set(gcf,'color','w',  'Position', [200, 50, 1100, 400]);
            set(gcf,'DefaultAxesColorOrder',handles.mydata.colormap);
            box on
        else
            figure(131)
            if get(handles.rb_new_plot,'Value')
                hold on
            end
        end

        for kk = 1:numel(handles.mydata.active_sets)
            if handles.mydata.plot_flag(handles.mydata.active_sets(kk))
                hold on
                dx = (handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x(end,1)-handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x(1,1))/(size(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_x,1)-1);
                [fsignal frequencies] = myFourier(dx*10^3, handles.mydata.datasets{handles.mydata.active_sets(kk)}.slope_err*10^6);
                plot(frequencies, fsignal,'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},'Color', handles.mydata.colormap(handles.mydata.active_sets(kk),:), 'LineWidth',2)
            end
        end
        hold off
        xlabel('Frequencies  [1/mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Fsignal  [1/urad]','Fontsize',12,'FontWeight','bold')
        l = legend('show');  set(l,'Interpreter', 'none','Location','best')
    end
    drawnow

     
     

% PLOT FFT SLOPE ERROR vs SLOPE
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     if get(handles.cb_plot_FFT_slope_err_vs_slope,'Value')    
            if ~ishandle(132)
                figure(132),   set(gcf,'color','w',  'Position', [200, 50, 1100, 400]);  
                set(gcf,'DefaultAxesColorOrder',handles.mydata.colormap);
                box on
            else
                figure(132)
                if get(handles.rb_new_plot,'Value')
                    hold on
                end
            end       
            for kk = 1:numel(handles.mydata.active_sets)
                if handles.mydata.plot_flag(handles.mydata.active_sets(kk))                    
                    dphi = (max(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi)-min(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi))/numel(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi); 
                    phi1 = min(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi);
                    phi2 = max(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi);
                    active_phi = linspace(phi1,phi2,(phi2-phi1)/dphi+1)';
                    slope_err  = interp1(handles.mydata.datasets{handles.mydata.active_sets(kk)}.active_phi,handles.mydata.datasets{handles.mydata.active_sets(kk)}.slope_err,active_phi,'pchip');
                    dx = (active_phi(end,1)-active_phi(1,1))/(size(active_phi,1)-1);
                    [fsignal frequencies] = myFourier(dx*10^6, handles.mydata.datasets{handles.mydata.active_sets(kk)}.slope_err*10^6);
                    plot(frequencies, fsignal,'DisplayName',handles.mydata.set_names{handles.mydata.active_sets(kk)},...
                        'Color', handles.mydata.colormap(kk,:), 'LineWidth',2) 
                    hold on     
                end            
            end
            hold off
            xlabel('Slope [1/urad]','Fontsize',12,'FontWeight','bold')
            ylabel('Slope error  [1/urad]','Fontsize',12,'FontWeight','bold') 
            l = legend('show');  set(l,'Interpreter', 'none','Location','best')
     end    
     drawnow         
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 

 
% ************ closes all plot windows  ************
function pb_close_figs_Callback(hObject, eventdata, handles)
    all_figs = findobj(0, 'type', 'figure');
    
    for kk = 1:size(all_figs,1)
        h = all_figs(kk).Number;
        neofigs = [111:115 121:123 131:132];
        if isnumeric(h) && numel(h)>0         
            if sum((h==neofigs))>0
                close(h)
            end
        end
    end
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
    

    
% --- Executes on selection change in lb_loaded_datasets.
function lb_loaded_datasets_Callback(hObject, eventdata, handles)
    
    handles.mydata.crt_set = get(hObject,'Value');
 
    % refresh display
    set(handles.cb_flip,'Value',handles.mydata.flip_flag(handles.mydata.crt_set));
    set(handles.cb_plot,'Value',handles.mydata.plot_flag(handles.mydata.crt_set));    
    set(handles.e_name,'String',handles.mydata.set_names{handles.mydata.crt_set});
    set(handles.t_scan_file_name,'String',{'Scan file name:'; handles.mydata.scan_file_names{handles.mydata.crt_set}});
    set(handles.e_offset_x,'String',num2str(handles.mydata.x_offset(handles.mydata.crt_set)*10^3));
    
    % Update handles structure
    guidata(hObject, handles);    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%      *** EMBEDDED FUNCTIONS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% --- Reset all GUI controls after flush ---
function handles = reset_uicontrols(hObject,handles)
    default_string = get(handles.lb_loaded_datasets,'UserData'); 
    set(handles.lb_loaded_datasets,'Value',1,'String',default_string); 

    
    % reset checkboxes   
    set(handles.cb_plot_figure,'Value',0)
    set(handles.cb_plot_figure_err,'Value',0)
    set(handles.cb_plot_slope_err,'Value',0)
    set(handles.cb_plot_twist_angle,'Value',0)
    set(handles.cb_plot_slope_err_vs_slope,'Value',0)
    set(handles.cb_plot_figure_err_vs_slope,'Value',0)
    set(handles.cb_plot_FFT_slope_err_vs_x,'Value',0)
    set(handles.cb_plot_slope,'Value',0)
    set(handles.cb_plot_FFT_slope_err_vs_slope,'Value',0)
    set(handles.rb_plot_fitted,'Value',0)
    set(handles.rb_plot_mavg,'Value',0)
    set(handles.cb_plot,'Value',0)
    set(handles.cb_flip,'Value',0)
   
    % reset edit controls
    set(handles.e_name,'String','');
    set(handles.e_offset_x,'String','');
    
    % reset info textboxes     
    set(handles.t_scan_file_name,'String','Scan file name:');
    set(handles.t_smith_says,'String','Message:');    
    
    % Update handles structure
    guidata(hObject, handles);   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
    

% --- Refresh all GUI variables after flush ---    
function handles = reset_variables(hObject, handles)
    
%  flush previous data
    handles.mydata.datasets = cell(1,12);    
    handles.mydata.set_names = cell(1,12);   
    handles.mydata.scan_file_names = cell(1,12); 
    handles.mydata.active_sets = [];       
    handles.mydata.crt_set = 1;   
    handles.mydata.plot_flag = zeros(1,12);
    handles.mydata.flip_flag = zeros(1,12);
    handles.mydata.fitted_flag = zeros(3,12);
    handles.mydata.mavg_flag = zeros(1,12);
    handles.mydata.x_offset = zeros(1,12);       
    
    default_string = {'01.   ---------','02.   ---------','03.   ---------','04.   ---------',...
                      '05.   ---------','06.   ---------','07.   ---------','08.   ---------',...
                      '09.   ---------','10.   ---------','11.   ---------','12.   ---------'}; 
    set(handles.lb_loaded_datasets,'UserData',default_string);   
    
    handles.mydata.colormap = [0 0 1;  0 0.7 0;  1 0 0;  0 0.6 0.6;  0.6  0  0.9;  1  0.6  0;  0.7 0 0.1;  0 0 0;  ...
                                0.9 0 0.6;  0 0 0.5;  0 0.8 0.9;  0  .9 0;  0.7 0.7 0;  0.4 0.4 0.4];
            
    handles.pathname = mfilename('fullpath');
    % 'C:\Users\elt29493\Documents\MATLAB\_function_library\GUIs\supersmith'
    handles.pathname = handles.pathname(1:end-length('_function_library\GUIs\supersmith'));         

% Update handles structure
    guidata(hObject, handles);     
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++      
    


% --------------------------------------------------------------------
%% ----------   UNUSED -----------------------------------------------
% --------------------------------------------------------------------
% --------------------------------------------------------------------


function cb_plot_FFT_slope_err_vs_slope_Callback(hObject, eventdata, handles)



   
function cb_plot_slope_Callback(hObject, eventdata, handles)

function rb_plot_fitted_Callback(hObject, eventdata, handles)


function rb_plot_mavg_Callback(hObject, eventdata, handles)


% --- Executes on button press in cb_plot_twist_vs_slope.
function cb_plot_twist_vs_slope_Callback(hObject, eventdata, handles)
% hObject    handle to cb_plot_twist_vs_slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_plot_twist_vs_slope


% --- Executes on button press in cb_plot_FFT_slope_err_vs_x.
function cb_plot_FFT_slope_err_vs_x_Callback(hObject, eventdata, handles)
% hObject    handle to cb_plot_FFT_slope_err_vs_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_plot_FFT_slope_err_vs_x


% --- Executes on button press in cb_plot_twist_vs_NOM_x.
function cb_plot_twist_vs_NOM_x_Callback(hObject, eventdata, handles)
% hObject    handle to cb_plot_twist_vs_NOM_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cb_plot_twist_vs_NOM_x



