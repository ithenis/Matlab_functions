function varargout = morpheus(varargin)
% MORPHEUS MATLAB code for morpheus.fig
%      MORPHEUS, by itself, creates a new MORPHEUS or raises the existing
%      singleton*.
%
%      H = MORPHEUS returns the handle to a new MORPHEUS or the handle to
%      the existing singleton*.
%
%      MORPHEUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MORPHEUS.M with the given input arguments.
%
%      MORPHEUS('Property','Value',...) creates a new MORPHEUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before morpheus_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to morpheus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help morpheus

% Last Modified by GUIDE v2.5 25-Jan-2017 16:30:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @morpheus_OpeningFcn, ...
                   'gui_OutputFcn',  @morpheus_OutputFcn, ...
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


% --- Executes just before morpheus is made visible.
function morpheus_OpeningFcn(hObject, eventdata, handles, varargin)

    handles.pathname = pwd;



% Update handles structure
guidata(hObject, handles);




% --- Outputs from this function are returned to the command line.
function varargout = morpheus_OutputFcn(hObject, eventdata, handles) 

% varargout{1} = handles.output;



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%      *** MENU CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV



%% ------ MENU GENERAL ---------------------------------------------


% *** clear variables from  workkspace  *** 
function m_clear_Callback(hObject, eventdata, handles)
    evalin('base','clear')
    
    
% *** clear command panel  ***     
function m_clc_Callback(hObject, eventdata, handles)
    evalin('base','clc')

    

% *** send handles to workspace  *** 
function m_handles2base_Callback(hObject, eventdata, handles)
    assignin('base','handles',handles);    
 


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




% --- load prf data 
function pb_load_prfs_Callback(hObject, eventdata, handles)
    if get(handles.rb_workspace_prfs,'Value')==1   % load from workspace (dropped by NEO)
        handles.prfdata = struct;
        evalin('base','save dummy');
        handles.prfdata = load('dummy.mat');
        handles.datanames{1} = handles.prfdata.namelist{1};
        delete('dummy.mat');
    else  %  load from .mat file
        pathN = handles.pathname;   
        [fileN,pathN] = uigetfile([pathN '\*.mat']);
        if fileN == 0           
            disp('user abort')
            return
        end
        handles.prfdata = struct;
        handles.prfdata = load([pathN fileN]);
        handles.datanames{1} = handles.prfdata.namelist{1}; 
    end
    
% Update handles structure
guidata(hObject, handles);  



% --- load error scan (0V, or optimisation)
function pb_load_error_scan_Callback(hObject, eventdata, handles)
    if get(handles.rb_workspace_error,'Value')==1
        handles.errordata = struct;
        evalin('base','save dummy');
        handles.errordata = load('dummy.mat');
        handles.datanames{2} = handles.errordata.namelist{1};
        delete('dummy.mat');
    elseif get(handles.rb_file_error,'Value')==1
        pathN = handles.pathname;
        [fileN,pathN] = uigetfile([pathN '\*.mat']);
        if fileN == 0
            disp('user abort')
            return
            handles.errordata = struct;
            handles.errordata = load([pathN fileN]);
            handles.datanames{2} = handles.errordata.namelist{1};
        end
    else
        disp('not yet')
    end

    % Update handles structure
    guidata(hObject, handles);  

% --- input prf voltage
function e_PRF_voltage_Callback(hObject, eventdata, handles)
    handles.prfdata.prf_voltage = str2num(get(hObject,'String'));


% Update handles structure
guidata(hObject, handles);  


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)



function e_piezo_voltage_Callback(hObject, eventdata, handles)
% hObject    handle to e_piezo_voltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_piezo_voltage as text
%        str2double(get(hObject,'String')) returns contents of e_piezo_voltage as a double


% --- Executes during object creation, after setting all properties.
function e_piezo_voltage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to e_piezo_voltage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
