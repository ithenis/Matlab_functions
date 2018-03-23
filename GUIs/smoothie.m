function varargout = smoothie(varargin)
% smoothie applies moving average to GTX scans
% expects a structure as input. if no input, user can load from file or
% from base

                % Begin initialization code - DO NOT EDIT
                gui_Singleton = 1;
                gui_State = struct('gui_Name',       mfilename, ...
                                   'gui_Singleton',  gui_Singleton, ...
                                   'gui_OpeningFcn', @smoothie_OpeningFcn, ...
                                   'gui_OutputFcn',  @smoothie_OutputFcn, ...
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


% --- Executes just before smoothie is made visible.
function smoothie_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.pathname = mfilename('fullpath');
    handles.pathname = handles.pathname(1:end-length('smoothie'));  
    if numel(varargin) ~= 1
        handles.mydata = struct;
        set(handles.listbox1,'String','-----')
    else
        handles.mydata = varargin{1};
        set(handles.listbox1,'String',handles.mydata.namelist{1})
        handles.mydata.dx = handles.mydata.active_x(2,1) - handles.mydata.active_x(1,1);
        set(handles.t_dx,'String',['dx [um]:   ' num2str(handles.mydata.dx*10^6)]);
 
    end
    handles.flag = 0;
    handles.output = hObject;
    
    % Update handles structure
    guidata(hObject, handles);
    uiwait(gcf);
    
    
    


% --- Outputs from this function are returned to the command line.
function varargout = smoothie_OutputFcn(hObject, eventdata, handles) 

    uiresume(gcf)
    guidata(hObject, handles)

    varargout{1} = handles.mydata;
    close(handles.figure1)
    % YES!!!


  

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                   UICONTROL CALLBACKS
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




% ************   load data from workspace  ************
function pb_load_from_base_Callback(hObject, eventdata, handles)
    evalin('base','save dummy');
    handles.mydata = load('dummy.mat');  
    delete('dummy.mat');
    if isfield(handles.mydata,'namelist')
        set(handles.listbox1,'String',handles.mydata.namelist{1})
    else
        disp('It has to be a NEO output! Operation aborted')
        handles.mydata = struct;
    end
    % Update handles structure
    guidata(hObject, handles); 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 


% *******   load data from file. It has to be a NEO output file!  *********
function pb_load_from_file_Callback(hObject, eventdata, handles)

    % load data
    pathN = handles.pathname;   
    [fileN,pathN] = uigetfile([pathN '\*.mat']);
    if fileN == 0           
        disp('user abort')
        return
    end 
    handles.pathname = pathN;
    
    handles.mydata = load([pathN fileN]);
    if isfield(handles.mydata,'namelist')
        set(handles.listbox1,'String',handles.mydata.namelist{1})
    else
        disp('It has to be a NEO output file! Operation aborted')
        handles.mydata = struct;
    end
    
    % Update handles structure
    guidata(hObject, handles); 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    




function pb_GO_Callback(hObject, eventdata, handles)
    if isfield(handles.mydata,'active_x')
        handles.mydata.mavg.span = str2num(get(handles.e_span,'String'));
        if mod(handles.mydata.mavg.span,2)==0
            handles.mydata.mavg.span = handles.mydata.mavg.span+1;
        end
        handles.mydata.mavg.slope_err_smooth = moving_average(handles.mydata.active_x, handles.mydata.slope_err, handles.mydata.mavg.span, 'smooth');
        handles.mydata.mavg.slope_err_smooth_rms =  get_rms(handles.mydata.mavg.slope_err_smooth);
        handles.mydata.mavg.height_err_smooth = intnom(handles.mydata.mavg.slope_err_smooth,handles.mydata.dx);
        handles.mydata.mavg.height_err_smooth_rms =  get_rms(handles.mydata.mavg.height_err_smooth);
        
    else
        disp('Garrrh, what''s the point?')
    end
    varargout = smoothie_OutputFcn(hObject, eventdata, handles);

    handles.flag = 1;
    % Update handles structure
    guidata(hObject, handles);
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    

function listbox1_Callback(hObject, eventdata, handles)





function e_span_Callback(hObject, eventdata, handles)
    handles.mydata.mavg.span = str2num(get(handles.e_span,'String'));    
    set(handles.t_width,'String',['width [mm]:   ' num2str(handles.mydata.mavg.span*handles.mydata.dx*10^3)]);
    % Update handles structure
    guidata(hObject, handles);




% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)  
  if handles.flag==1
      delete(gcf)  
  else
%       disp('press done first')
  end
    




    
