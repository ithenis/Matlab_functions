function varargout = trimster(varargin)

                gui_Singleton = 1;
                gui_State = struct('gui_Name',       mfilename, ...
                                   'gui_Singleton',  gui_Singleton, ...
                                   'gui_OpeningFcn', @trimster_OpeningFcn, ...
                                   'gui_OutputFcn',  @trimster_OutputFcn, ...
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
function trimster_OpeningFcn(hObject, eventdata, handles, varargin)

    handles.mydata = struct;
    load('FIZdata.mat')
    handles.mydata.map = data;
    
    [handles.mydata.ymax handles.mydata.xmax] = size(handles.mydata.map);
    
    % set trim coordinates
    handles.mydata.y1 = 1;
    handles.mydata.y2 = handles.mydata.ymax;
    handles.mydata.x1 = 1;
    handles.mydata.x2 = handles.mydata.xmax;
    
    % set sliders
    set(handles.s_y1,'Style', 'slider', 'Min',1,'Max',handles.mydata.ymax, 'SliderStep',...
                        [1 10]/(handles.mydata.ymax-1), 'Value',handles.mydata.ymax-handles.mydata.y1+1);
    set(handles.s_y2,'Style', 'slider', 'Min',1,'Max',handles.mydata.ymax, 'SliderStep',...
                        [1 10]/(handles.mydata.ymax-1), 'Value',handles.mydata.ymax-handles.mydata.y2+1);
    set(handles.s_x1,'Style', 'slider', 'Min',1,'Max',handles.mydata.xmax, 'SliderStep',...
                        [1 10]/(handles.mydata.xmax-1), 'Value',handles.mydata.x1);
    set(handles.s_x2,'Style', 'slider', 'Min',1,'Max',handles.mydata.xmax, 'SliderStep',...
                        [1 10]/(handles.mydata.xmax-1), 'Value',handles.mydata.x2);
    
    
    % set edits
    set(handles.e_y1,'String',handles.mydata.y1);
    set(handles.e_y2,'String',handles.mydata.y2);
    set(handles.e_x1,'String',handles.mydata.x1);
    set(handles.e_x2,'String',handles.mydata.x2);
    
    
    axes(handles.axes1)
    imagesc(handles.mydata.map)
    axis equal
    axis off

    % Choose default command line output for trimster
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes trimster wait for user response (see UIRESUME)
    % uiwait(handles.figure1);



% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function varargout = trimster_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;





   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%      *** MENU CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV




%% ------ MENU GENERAL ---------------------------------------------

% *** clear command panel  *** 
function m_CLC_Callback(hObject, eventdata, handles)
    evalin('base','clc')


% *** clear variables from  workkspace  *** 
function m_clear_Callback(hObject, eventdata, handles)
    evalin('base','clear')


%% ------ MENU TO BASE ---------------------------------------------   


% *** send handles to workspace  *** 
function m_handles2base_Callback(hObject, eventdata, handles)
     assignin('base','handles',handles);



   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




% trims map 
function pb_autotrim_Callback(hObject, eventdata, handles)




function pb_reset_Callback(hObject, eventdata, handles)




% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function s_y1_Callback(hObject, eventdata, handles)
    val = handles.mydata.ymax-round(get(hObject, 'Value'))+1;
    if (val>=1)&&(val<handles.mydata.y2)
        handles.mydata.y1 = val;
        set(handles.e_y1,'String',handles.mydata.y1);  
        refresh(hObject,handles);           
    else
        disp('y1 out of limits');
        set(handles.s_y1,'Value',val); 
    end   
    % Update handles structure
    guidata(hObject, handles);
 

    
function e_y1_Callback(hObject, eventdata, handles)
    val = str2num(get(hObject, 'String'));
    if (val>=1)&&(val<handles.mydata.y2)
        handles.mydata.y1 = val;
        set(handles.s_y1,'Value',handles.mydata.ymax-handles.mydata.y1+1);    
        refresh(hObject,handles);      
    else
        disp('y1 out of limits');
        set(handles.e_y1,'String',num2str(handles.mydata.y1));          
    end    
    % Update handles structure
    guidata(hObject, handles);

     
                            
function pb_y1_Callback(hObject, eventdata, handles)
    [x y] = ginput(1);
    handles.mydata.y1 = round(y);
    set(handles.s_y1,'Value',handles.mydata.ymax-handles.mydata.y1+1);  
    set(handles.e_y1,'String',num2str(handles.mydata.y1));     
    if handles.mydata.y1>=handles.mydata.y2;
       handles.mydata.y2 = handles.mydata.y1+1;
       set(handles.s_y2,'Value',handles.mydata.ymax-handles.mydata.y2+1);  
       set(handles.e_y2,'String',num2str(handles.mydata.y2));
    end   
    refresh(hObject,handles); 
    % Update handles structure
    guidata(hObject, handles);                        
                            
                                                       
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function s_y2_Callback(hObject, eventdata, handles)
	val = handles.mydata.ymax-round(get(hObject, 'Value'))+1;
    if (val<=handles.mydata.ymax)&&(val>handles.mydata.y1)
        handles.mydata.y2 = val;
        set(handles.e_y2,'String',handles.mydata.y2);
        refresh(hObject,handles);      
    else
        disp('y2 out of limits');
        set(handles.s_y2,'Value',handles.mydata.ymax-handles.mydata.y2+1); 
    end
    % Update handles structure
    guidata(hObject, handles);
    


function e_y2_Callback(hObject, eventdata, handles)
    val = str2num(get(hObject, 'String'));
    if (val<=handles.mydata.ymax)&&(val>handles.mydata.y1)
        handles.mydata.y2 = val;
        set(handles.s_y2,'Value',handles.mydata.ymax-handles.mydata.y2+1);    
        refresh(hObject,handles);      
    else
        disp('y2 out of limits');
        set(handles.e_y2,'String',num2str(handles.mydata.y2));
    end
    % Update handles structure
    guidata(hObject, handles);
        
    
    
function pb_y2_Callback(hObject, eventdata, handles)
    [x y] = ginput(1);
    handles.mydata.y2 = round(y);
    set(handles.s_y2,'Value',handles.mydata.ymax-handles.mydata.y2+1);  
    set(handles.e_y2,'String',num2str(handles.mydata.y2));     
    if handles.mydata.y2<=handles.mydata.y1;
       handles.mydata.y1 = handles.mydata.y2-1;
       set(handles.s_y1,'Value',handles.mydata.ymax-handles.mydata.y1+1);  
       set(handles.e_y1,'String',num2str(handles.mydata.y1));
    end
    refresh(hObject,handles);  
    % Update handles structure
    guidata(hObject, handles);


% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function s_x1_Callback(hObject, eventdata, handles)
    val = round(get(hObject, 'Value'));
    if (val>=1)&&(val<handles.mydata.x2)
        handles.mydata.x1 = val;
        set(handles.e_x1,'String',num2str(handles.mydata.x1));
        refresh(hObject,handles);      
    else
        disp('x1 out of limits');
        set(handles.s_x1,'Value',handles.mydata.x1); 
    end
    % Update handles structure
    guidata(hObject, handles);
    
    
function e_x1_Callback(hObject, eventdata, handles)
    val = str2num((get(hObject, 'Value')));
    if (val>=1)&&(val<handles.mydata.x2)
        handles.mydata.x1 = val;
        set(handles.z_x1,'Value',handles.mydata.x1);
        refresh(hObject,handles);      
    else
        disp('x1 out of limits');
        set(handles.e_x1,'Value',num2str(handles.mydata.x1)); 
    end
    % Update handles structure
    guidata(hObject, handles);

    
    
function pb_x1_Callback(hObject, eventdata, handles)
    [x y] = ginput(1);
    handles.mydata.x1 = round(x);
    set(handles.e_x1,'String',handles.mydata.x1);
    set(handles.s_x1,'Value',handles.mydata.x1);         
    if handles.mydata.x1>=handles.mydata.x2
        handles.mydata.x2=handles.mydata.x1+1;
        set(handles.s_x1,'Value',handles.mydata.x1);
        set(handles.e_x1,'String',num2str(handles.mydata.x1)); 
    end
    refresh(hObject,handles);  
    % Update handles structure
    guidata(hObject, handles);
    
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function s_x2_Callback(hObject, eventdata, handles)
    val = round(get(hObject, 'Value'));
    if (val<=handles.mydata.xmax)&&(val>handles.mydata.x1)
        handles.mydata.x2 = val;
        set(handles.e_x2,'String',num2str(handles.mydata.x2));
        refresh(hObject,handles);      
    else
        disp('x2 out of limits');
        set(handles.s_x2,'Value',handles.mydata.x2); 
    end
    % Update handles structure
    guidata(hObject, handles);
    
    
function e_x2_Callback(hObject, eventdata, handles)
    val = str2num(get(hObject, 'String'));
    if (val<=handles.mydata.xmax)&&(val>handles.mydata.x1)
        handles.mydata.x2 = val;
        set(handles.s_x2,'Value',handles.mydata.x2);
        refresh(hObject,handles);      
    else
        disp('x2 out of limits');
        set(handles.e_x2,'Value',num2str(handles.mydata.x2)); 
    end
    % Update handles structure
    guidata(hObject, handles);
   
    
function pb_x2_Callback(hObject, eventdata, handles)
    [x y] = ginput(1);
    handles.mydata.x2 = round(x);
    set(handles.e_x2,'String',handles.mydata.x2);
    set(handles.s_x2,'Value',handles.mydata.x2);     
    if handles.mydata.x2<=handles.mydata.x1
        handles.mydata.x1=handles.mydata.x2-1;
        set(handles.s_x2,'Value',handles.mydata.x2);
        set(handles.e_x2,'String',num2str(handles.mydata.x2)); 
    end
    refresh(hObject,handles);  
    % Update handles structure
    guidata(hObject, handles);
    
     
    

% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function listbox1_Callback(hObject, eventdata, handles)





% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%      END OF  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%      *** EMBEDDED FUNCTIONS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function handles = refresh(hObject,handles,label,value)
        axes(handles.axes1)
        imagesc(handles.mydata.map)
        hold on
        rectangle('Position',[handles.mydata.x1,handles.mydata.y1,handles.mydata.x2-handles.mydata.x1,handles.mydata.y2-handles.mydata.y1],...
            'EdgeColor','r','LineWidth',2,'LineStyle','--')
        hold off
        axis equal
        axis off
        drawnow

            
         

function pb_manual_rectangle_Callback(hObject, eventdata, handles)
