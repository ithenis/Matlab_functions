function varargout = Speck(varargin)

                gui_Singleton = 1;
                gui_State = struct('gui_Name',       mfilename, ...
                                   'gui_Singleton',  gui_Singleton, ...
                                   'gui_OpeningFcn', @Speck_OpeningFcn, ...
                                   'gui_OutputFcn',  @Speck_OutputFcn, ...
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


% --- Executes just before Speck is made visible.
function Speck_OpeningFcn(hObject, eventdata, handles, varargin)

    set(handles.uip_ellipse_params,'Visible', 'off')        
    set(handles.uip_cylinder_params,'Visible', 'on')
    set(handles.rb_cylinder,'Value', 1)

    handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = Speck_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;










% --- Executes on button press in pb_GO.
function pb_GO_Callback(hObject, eventdata, handles)

    
% destroy previous analysis
    handles.myanalysis = struct;    
   
% check analysis parameters     
    L = str2num(get(handles.e_length,'String'));
    handles.myanalysis.active_L = L;
    
    dx = str2num(get(handles.e_dx,'String'))*10^-3;
    handles.myanalysis.dx = dx;
    
    handles.myanalysis.x = 0:dx:L;
    
    if get(handles.rb_cylinder,'Value')==1
        shape = 'cylinder';
        R = str2num(get(handles.e_R_cylinder,'String'));
        params = [R];         
    elseif get(handles.rb_ellipse,'Value')==1
        shape = 'ellipse';
        P = str2num(get(handles.e_P_ellipse,'String'));
        Q = str2num(get(handles.e_Q_ellipse,'String'));
        theta = str2num(get(handles.e_theta_ellipse,'String'));
        if get(handles.cb_sign_ellipse,'Value')
            semn =  1;
        else
            semn = -1;
        end
        params = [P Q theta semn];        
    end
    
    handles.myanalysis.ellipse_params = params;

 
 % create shape   
    output = analyse1Ddata(handles.mydata.x, handles.mydata.phi, handles.mydata.phi_roll,handles.mydata.height, [L xc], params)
disp('Boo!!!')


% --- Executes when selected object is changed in rb_shape.
function rb_shape_SelectionChangedFcn(hObject, eventdata, handles)
if strcmp(get(hObject,'String'),'cylinder')     
        set(handles.uip_ellipse_params,'Visible', 'off')        
        set(handles.uip_cylinder_params,'Visible', 'on')
    elseif  strcmp(get(hObject,'String'),'ellipse')
        set(handles.uip_cylinder_params,'Visible', 'off')
        set(handles.uip_ellipse_params,'Visible', 'on')        
    else   
        set(handles.uip_ellipse_params,'Visible', 'off')        
        set(handles.uip_cylinder_params,'Visible', 'on')
end




















function e_P_ellipse_Callback(hObject, eventdata, handles)


function e_Q_ellipse_Callback(hObject, eventdata, handles)


function e_theta_ellipse_Callback(hObject, eventdata, handles)



function e_length_Callback(hObject, eventdata, handles)



function e_dx_Callback(hObject, eventdata, handles)



% --- Executes on button press in cb_sign_ellipse.
function cb_sign_ellipse_Callback(hObject, eventdata, handles)



function pb_joker_Callback(hObject, eventdata, handles)
     assignin('base','handles',handles);

  



function e_R_cylinder_Callback(hObject, eventdata, handles)
% hObject    handle to e_R_cylinder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of e_R_cylinder as text
%        str2double(get(hObject,'String')) returns contents of e_R_cylinder as a double
