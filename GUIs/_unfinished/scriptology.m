function varargout = scriptology(varargin)

% for now, it only has script 1 to deal with

                % Begin initialization code - DO NOT EDIT
                gui_Singleton = 1;
                gui_State = struct('gui_Name',       mfilename, ...
                                   'gui_Singleton',  gui_Singleton, ...
                                   'gui_OpeningFcn', @scriptology_OpeningFcn, ...
                                   'gui_OutputFcn',  @scriptology_OutputFcn, ...
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


% --- Executes just before scriptology is made visible.
function scriptology_OpeningFcn(hObject, eventdata, handles, varargin)

    % set UICONTROLS initial values 
    
    set(handles.rb_2positions,'Value',1);
    set(handles.rb_2iterations,'Value',1);
    
    handles = refresh_gui(handles);

    handles.pathname = 'C:\Users\elt29493\Documents\MATLAB\Beamline_optics';






handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes scriptology wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = scriptology_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

       


  
   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** MENU CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV


%% ------ MENU GENERAL ---------------------------------------------


% *** clear command panel  *** 
function m_clc_Callback(hObject, eventdata, handles)
    evalin('base','clc')


% *** clear variables from  workkspace  ***
function m_clear_all_Callback(hObject, eventdata, handles)
    evalin('base','clear')

    
    
    
%% ------ MENU TO BASE ---------------------------------------------   
     
% *** send handles to workspace  *** 
function m_handles_to_base_Callback(hObject, eventdata, handles)
    assignin('base','handles',handles);  






% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% --- Executes on button press in pb_script1.
function pb_script1_Callback(hObject, eventdata, handles)
    description = 'compares fizeau measurements of an optic in several states: initial state, change1, change2, etc.';
    set(handles.t_description,'String',description)


% --- Executes on button press in pb_load_base.
function pb_load_base_Callback(hObject, eventdata, handles)
    evalin('base','save dummy');
    handles.loaded = load('dummy.mat');    
    delete('dummy.mat');
    names = fieldnames(handles.loaded);
    set(handles.lb_loaded_variables,'Value',1,'String',names); 
    
    
    
    


function pb_load_file_Callback(hObject, eventdata, handles)
    pathN = handles.pathname;
    [fileN,pathN] = uigetfile([pathN '\*.mat']);
    if fileN == 0
        disp('user abort')
        return
    end
    handles.pathname = pathN;
    handles.loaded = struct;    
    handles.loaded = load([pathN fileN]);
    names = fieldnames(handles.loaded);
    set(handles.lb_loaded_variables,'Value',1,'String',names); 
    % Update handles structure
    guidata(hObject, handles);


    
function lb_loaded_variables_Callback(hObject, eventdata, handles)



% --- Executes on button press in pb_delete_variable.
function pb_delete_variable_Callback(hObject, eventdata, handles)



% --- Executes when selected object is changed in uib_N_scan_positions.
function uib_N_scan_positions_SelectionChangedFcn(hObject, eventdata, handles)
    handles = refresh_gui(handles);
    
    % Update handles structure
    guidata(hObject, handles);
    
    
    
% --- Executes when selected object is changed in uib_iterations.
function uib_iterations_SelectionChangedFcn(hObject, eventdata, handles)
    handles = refresh_gui(handles);
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in pb_send_var.
function pb_send_var_Callback(hObject, eventdata, handles)
    names = get(handles.lb_loaded_variables,'String'); 
    idx = get(handles.lb_loaded_variables,'Value'); 
    if eval(['isstruct(handles.loaded.' names{idx} ');'])
        eval(['handles.sets.' handles.sets.crt_set '= handles.loaded.' names{idx} ';'])
        eval(['set(handles.pb_' handles.sets.crt_set ', ''ForegroundColor'',''r'');']);
    else
        disp('not a structure')
    end
    % Update handles structure
    guidata(hObject, handles);

     
    
% --- Executes on button press in pb_send_all.
function pb_send_all_Callback(hObject, eventdata, handles)
    eval(['handles.sets.' handles.sets.crt_set '= handles.loaded'])
    eval(['set(handles.pb_' handles.sets.crt_set ', ''ForegroundColor'',''r'');']);
    % Update handles structure
    guidata(hObject, handles);

function pb_L0_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: L0')
    handles.sets.crt_set = 'L0';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_C0_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: C0')
    handles.sets.crt_set = 'C0';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_R0_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: R0')
    handles.sets.crt_set = 'R0';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_L1_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: L1')
    handles.sets.crt_set = 'L1';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_C1_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: C1')
    handles.sets.crt_set = 'C1';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_R1_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: R1')
    handles.sets.crt_set = 'R1';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_L2_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: L2')
    handles.sets.crt_set = 'L2';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_C2_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: C2')
    handles.sets.crt_set = 'C2';
    % Update handles structure
    guidata(hObject, handles);

    
function pb_R2_Callback(hObject, eventdata, handles)
    handles = buttonz(handles);
    set(handles.t_current_set,'String','Current set: R2')
    handles.sets.crt_set = 'R2';
    % Update handles structure
    guidata(hObject, handles);







  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%%                  *** INBUILT FUNCTIONS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



function handles = refresh_gui(handles);
    states = {'on' 'on' 'on'; 'on' 'on' 'on'; 'on' 'on' 'on'};
    if get(handles.rb_1position,'Value')
        states(:,1) = {'off'};
        states(:,3) = {'off'};
    elseif get(handles.rb_2positions,'Value')
        states(:,2) = {'off'};
    end
    if get(handles.rb_2iterations,'Value')        
        states(3,:) = {'off'};  
    end

    set(handles.pb_L0,'Visible',states{1,1})
    set(handles.pb_L1,'Visible',states{2,1})
    set(handles.pb_L2,'Visible',states{3,1})
    
    set(handles.pb_C0,'Visible',states{1,2})
    set(handles.pb_C1,'Visible',states{2,2})
    set(handles.pb_C2,'Visible',states{3,2})
    
    set(handles.pb_R0,'Visible',states{1,3})
    set(handles.pb_R1,'Visible',states{2,3})
    set(handles.pb_R2,'Visible',states{3,3})
    

%{
    set(handles.pb_C0,'BackgroundColor',[0.9400 0.9400 0.9400])
    set(handles.pb_C0,'FontWeight','normal')
    set(handles.pb_C1,'Visible','off')
    set(handles.pb_C2,'Visible','off')
%}


function handles = buttonz(handles);

buttonz = [get(handles.pb_L0,'Value') get(handles.pb_C0,'Value') get(handles.pb_R0,'Value');...
            get(handles.pb_L1,'Value') get(handles.pb_C1,'Value') get(handles.pb_R1,'Value');...
            get(handles.pb_L2,'Value') get(handles.pb_C2,'Value') get(handles.pb_R2,'Value')];






function pb_new_Callback(hObject, eventdata, handles)
disp('reset everything')

% reset set buttons.
% empty loaded and sets structures
handles.loaded = struct;
handles.sets = struct;







