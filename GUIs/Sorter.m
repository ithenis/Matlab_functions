function varargout = Sorter(varargin)
% SORTER MATLAB code for Sorter.fig
% Sorter sorts a file name list


            % Begin initialization code - DO NOT EDIT
            gui_Singleton = 1;
            gui_State = struct('gui_Name',       mfilename, ...
                               'gui_Singleton',  gui_Singleton, ...
                               'gui_OpeningFcn', @Sorter_OpeningFcn, ...
                               'gui_OutputFcn',  @Sorter_OutputFcn, ...
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


% --- Executes just before Sorter is made visible.
function Sorter_OpeningFcn(hObject, eventdata, handles, varargin) %#ok<*INUSL>

    if numel(varargin) ~= 1
        handles.fname = {'un','doi','trei','patru','cinci','sase','sapte','opt','noua','zece'}';
    else
        handles.fname = varargin{1}';
        for ii = 1:numel(handles.fname)
            if isempty(handles.fname{ii})
                handles.fname{ii} = '---';
            end
        end
    end
    set(handles.listbox1,'String',handles.fname)
    handles.flag = 0;
    handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
uiwait(gcf);


function varargout = Sorter_OutputFcn(hObject, eventdata, handles) 
uiresume(gcf)
guidata(hObject, handles)

for ii = 1:numel(handles.fname)
    if strcmp(handles.fname{ii}, '---')
        handles.fname{ii} = '';
        
    end
end
varargout{1} = handles.fname;
close(handles.figure1)
% YES!!!




  
  

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                   UICONTROL CALLBACKS
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


    

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_up_Callback(hObject, eventdata, handles)
    
    idx = get(handles.listbox1,'Value');    
    
    if idx(1)>1    
        list = cat(1,handles.fname(1:idx(1)-2),handles.fname(idx),...
                     handles.fname(idx(1)-1), handles.fname(idx(end)+1:end));

        handles.fname = list;
        set(handles.listbox1,'Value',idx-1);
        set(handles.listbox1,'String',list);
    end
    
    % Update handles structure
    guidata(hObject, handles);
    

    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_down_Callback(hObject, eventdata, handles) 
    
    idx = get(handles.listbox1,'Value');    
    
    if idx(end)< numel(handles.fname)
        list = cat(1,handles.fname(1:idx(1)-1),handles.fname(idx(end)+1),...
                 handles.fname(idx),handles.fname(idx(end)+2:end));
    
        handles.fname = list;
        set(handles.listbox1,'Value',idx+1);
        set(handles.listbox1,'String',list);
    end
    
    % Update handles structure
    guidata(hObject, handles);


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_first_Callback(hObject, eventdata, handles)
    idx = get(handles.listbox1,'Value');   
    
    if idx(1)> 1
        list = cat(1,handles.fname(idx),handles.fname(1:idx(1)-1),...
                    handles.fname(idx(end)+1:end));

        handles.fname = list;
        set(handles.listbox1,'Value',idx-idx(1)+1);
        set(handles.listbox1,'String',list);
    end
    
    % Update handles structure
    guidata(hObject, handles);

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_last_Callback(hObject, eventdata, handles)
    idx = get(handles.listbox1,'Value');    
    
    if idx(end)< numel(handles.fname)
        list = cat(1,handles.fname(1:idx(1)-1),...
                     handles.fname(idx(end)+1:end), handles.fname(idx));

        handles.fname = list;
        set(handles.listbox1,'Value',idx-idx(1)+numel(list));
        set(handles.listbox1,'String',list);
        
    end
    
    % Update handles structure
    guidata(hObject, handles);
    

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_reset_Callback(hObject, eventdata, handles)
    
   handles.fname = sort(handles.fname);
   set(handles.listbox1,'Value',1);
   set(handles.listbox1,'String',handles.fname);
   
   % Update handles structure
    guidata(hObject, handles);

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_flip_Callback(hObject, eventdata, handles)
    idx = get(handles.listbox1,'Value');    
    
    if numel(idx)>1
        list = cat(1,handles.fname(1:idx(1)-1),flipud(handles.fname(idx)),...
                     handles.fname(idx(end)+1:end));

        handles.fname = list;        
        set(handles.listbox1,'String',list);
    else
        disp('you need to select more than 1 item')
    end
    
    % Update handles structure
    guidata(hObject, handles);

    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_switch_Callback(hObject, eventdata, handles)
    idx = get(handles.listbox1,'Value');    
    
    if numel(idx)== 2
        list = cat(1,handles.fname(1:idx(1)-1),handles.fname(idx(2)),...
                     handles.fname(idx(1)+1:idx(2)-1),handles.fname(idx(1)),...
                     handles.fname(idx(2)+1:end));

        handles.fname = list;        
        set(handles.listbox1,'String',list);
    else
        disp('you need to select 2 items')
    end
    
    % Update handles structure
    guidata(hObject, handles);
    return
	assignin('base','handles',handles);  
    disp('Vworrrp... Vworrrrp... ')
    set(handles.figure1,'Visible','off')  
    pause(1)  
    movegui(handles.figure1,[100,200]) 
    set(handles.figure1,'Visible','on')
    disp('Vworrrp... Vworrrrp... ')
  
    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function pb_done_Callback(hObject, eventdata, handles) 
    
    assignin('base','fname',handles.fname)    
    varargout = Sorter_OutputFcn(hObject, eventdata, handles);
    
    handles.flag = 1;
    % Update handles structure
    guidata(hObject, handles);
    

 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
function listbox1_Callback(hObject, eventdata, handles)

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                function listbox1_CreateFcn(hObject, eventdata, handles)

                if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                    set(hObject,'BackgroundColor','white');
                end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)  
  if handles.flag==1
      delete(gcf)  
  else
%       disp('press done first')
  end
    
