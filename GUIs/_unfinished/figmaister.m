function varargout = figmaister(varargin);
% FIGMAISTER M-file for figmaister.fig

            % Begin initialization code - DO NOT EDIT
            gui_Singleton = 1;
            gui_State = struct('gui_Name',       mfilename, ...
                               'gui_Singleton',  gui_Singleton, ...
                               'gui_OpeningFcn', @figmaister_OpeningFcn, ...
                               'gui_OutputFcn',  @figmaister_OutputFcn, ...
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
function figmaister_OpeningFcn(hObject, eventdata, handles, varargin)      
    if nargin<4
        handles.fig_h = figure(11);
        handles.axes_h = get(handles.fig_h,'CurrentAxes');
    else    
        handles.fig_h = varargin{1};
        handles.axes_h = findobj(handles.fig_h,'Type','axes','-not','Tag','legend');
    end          
        % axes linewidth
        %  ==========================================================
        set(handles.t_lineweight,'String',get(handles.axes_h, 'LineWidth'));
        
       % title fontsize
       %  ==========================================================
        set(handles.rb_title,'Value',1)
        set(handles.e_string,'Visible','on')
        set(handles.e_xlabel,'Visible','off')
        set(handles.e_ylabel,'Visible','off')
        
        set(handles.e_fontname,'String',get(get(handles.axes_h,'Title'), 'FontName'));
        set(handles.t_fontsize,'String',get(get(handles.axes_h,'Title'), 'FontSize'));
        set(handles.e_string,'String',get(get(handles.axes_h,'Title'), 'String'));
        if strcmp(get(get(handles.axes_h,'Title'),'FontWeight'),'bold')
            set(handles.cb_bold,'Value',1)
        end
        if strcmp(get(get(handles.axes_h,'Title'),'FontAngle'),'italic')
            set(handles.cb_italic,'Value',1)
        end  
        
        
    % Limits    
        aa = get(handles.axes_h,'XLim')
        
        set(handles.e_xmin,'String',num2str(aa(1)));
        set(handles.e_xmax,'String',num2str(aa(2)));
        aa = get(handles.axes_h,'YLim');
        set(handles.e_ymin,'String',num2str(aa(1)));
        set(handles.e_ymax,'String',num2str(aa(2)));
        
    % Ticks       
        aa = get(handles.axes_h,'XTick');
        if ~isempty(aa)
            step = aa(2)-aa(1);
            set(handles.e_xtick_step,'String',num2str(step));
            set(handles.cb_xticks,'Value',1);
        else
            set(handles.e_xtick_step,'String','none');
            set(handles.cb_xticks,'Value',0);
        end
        aa = get(handles.axes_h,'YTick');
        if ~isempty(aa)
            step = aa(2)-aa(1);
            set(handles.e_ytick_step,'String',num2str(step));
            set(handles.cb_yticks,'Value',1);
        else
            set(handles.e_ytick_step,'String','none');
            set(handles.cb_yticks,'Value',0);
        end
        
    % grid  
        aa = get(handles.axes_h,'XGrid');
        if strcmp(aa,'on')
            set(handles.cb_xgrid,'Value',1);
        end
        aa = get(handles.axes_h,'YGrid');
        if strcmp(aa,'on')
            set(handles.cb_ygrid,'Value',1);
        end

    handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function varargout = figmaister_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


% ================================================================
%      Main uicontrols
% ================================================================

% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV

% ================================================================
function pb_linewidth_plus_Callback(hObject, eventdata, handles)

    aa = get(handles.axes_h,'Children');
    for kk = 1:numel(aa)
        bb = get(aa(kk),'LineWidth');
        set(aa(kk),'LineWidth', bb + 0.5);
    end
   
    set(handles.t_lineweight,'String',num2str(bb + 0.5));
    
    clear aa
    % Update handles structure
    guidata(hObject, handles);
    
% ================================================================    
function pb_linewidth_minus_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'Children');
    for kk = 1:numel(aa)
        bb = get(aa(kk),'LineWidth');
        set(aa(kk),'LineWidth', bb - 0.5);
    end
    
    set(handles.t_lineweight,'String',num2str(bb - 0.5));
   
    clear aa
    % Update handles structure
    guidata(hObject, handles);
 
    
% ================================================================
%  Font settings
% ================================================================
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
    
    if strcmp(get(hObject,'String'),'Title')        
        set(handles.e_string,'Visible','on')
        set(handles.e_xlabel,'Visible','off')
        set(handles.e_ylabel,'Visible','off')
        
        % refresh info
        aa = get(handles.axes_h,'Title');        
        set(handles.e_fontname,'String',get(aa, 'FontName'));
        set(handles.e_string,'String',get(aa, 'String'));        
        set(handles.cb_bold,'Value',strcmp(get(aa,'FontWeight'),'bold'))
        set(handles.cb_italic,'Value',strcmp(get(aa,'FontAngle'),'italic'))
       
        
    elseif strcmp(get(hObject,'String'),'Labels')           
        set(handles.e_string,'Visible','off')
        set(handles.e_xlabel,'Visible','on')
        set(handles.e_ylabel,'Visible','on')  
        
        % refresh info        
        set(handles.e_fontname, 'String',get(get(handles.axes_h,'XLabel'), 'FontName'))
        set(handles.e_xlabel, 'String', get(get(handles.axes_h,'XLabel'), 'String'))
        set(handles.e_ylabel,'String',get(get(handles.axes_h,'YLabel'),'String'))
        set(handles.cb_italic,'Value',strcmp(get(get(handles.axes_h,'XLabel'),'FontAngle'),'italic'))
        set(handles.cb_bold,'Value',strcmp(get(get(handles.axes_h,'XLabel'),'FontWeight'),'bold'))
        
    else
        set(handles.e_string,'Visible','off')
        set(handles.e_xlabel,'Visible','off')
        set(handles.e_ylabel,'Visible','off') 
        
        set(handles.e_fontname,  'String',  get(handles.axes_h,'FontName')) 
        set(handles.cb_italic,  'Value',  strcmp(get(handles.axes_h,'FontAngle'),'italic'))
        set(handles.cb_bold,  'Value',  strcmp(get(handles.axes_h,'FontWeight'),'bold'))
    end
        
    
% ================================================================        
function pb_fontsize_plus_Callback(hObject, eventdata, handles)
    if get(handles.rb_title,'Value')==1
        aa = get(handles.axes_h,'Title');
        bb = get(aa,'FontSize');
        set(aa,'FontSize', bb + 1);
        clear aa bb
    elseif get(handles.rb_labels,'Value')==1
        aa = get(get(handles.axes_h,'XLabel'),'FontSize');
        set(get(handles.axes_h,'XLabel'),'FontSize',aa + 1);
        bb = get(get(handles.axes_h,'YLabel'),'FontSize');
        set(get(handles.axes_h,'YLabel'),'FontSize',bb + 1);
        clear aa bb
    else
        aa = get(handles.axes_h,'FontSize');
        set(handles.axes_h,'FontSize',aa + 1);
        clear aa
    end
    

% ================================================================
function pb_fontsize_minus_Callback(hObject, eventdata, handles)
    if get(handles.rb_title,'Value')==1    
        aa = get(handles.axes_h,'Title');
        bb = get(aa,'FontSize');
        set(aa,'FontSize', bb - 1)
        clear aa bb
    elseif get(handles.rb_labels,'Value')==1
        aa = get(get(handles.axes_h,'XLabel'),'FontSize');
        set(get(handles.axes_h,'XLabel'),'FontSize',aa - 1)
        bb = get(get(handles.axes_h,'YLabel'),'FontSize');
        set(get(handles.axes_h,'YLabel'),'FontSize',bb - 1)
        clear aa bb
    else
        aa = get(handles.axes_h,'FontSize');
        set(handles.axes_h,'FontSize',aa - 1)
        clear aa
    end
    

% ================================================================
function cb_bold_Callback(hObject, eventdata, handles)    
    if get(handles.rb_title,'Value')==1   
        if get(handles.cb_bold,'Value')==1
            set(get(handles.axes_h,'Title'),'FontWeight','bold'); 
        else
            set(get(handles.axes_h,'Title'),'FontWeight','normal'); 
        end
    elseif get(handles.rb_labels,'Value')==1
        if get(handles.cb_bold,'Value')==1
            set(get(handles.axes_h,'XLabel'),'FontWeight','bold');
            set(get(handles.axes_h,'YLabel'),'FontWeight','bold'); 
        else
            set(get(handles.axes_h,'XLabel'),'FontWeight','normal');
            set(get(handles.axes_h,'YLabel'),'FontWeight','normal');
        end
    else
        if get(handles.cb_bold,'Value')==1
            set(handles.axes_h,'FontWeight','bold')            
        else
            set(handles.axes_h,'FontWeight','normal')          
        end
    end
    

% ================================================================
function cb_italic_Callback(hObject, eventdata, handles)
    if get(handles.rb_title,'Value')==1             
        if get(handles.cb_italic,'Value')==1
            set(get(handles.axes_h,'Title'),'FontAngle','italic'); 
        else
            set(get(handles.axes_h,'Title'),'FontAngle','normal'); 
        end
    elseif get(handles.rb_labels,'Value')==1
        if get(handles.cb_italic,'Value')==1            
            set(get(handles.axes_h,'XLabel'),'FontAngle','italic');
            set(get(handles.axes_h,'YLabel'),'FontAngle','italic');            
        else
            set(get(handles.axes_h,'XLabel'),'FontAngle','normal');
            set(get(handles.axes_h,'YLabel'),'FontAngle','normal');
        end
    else
        if get(handles.cb_italic,'Value')==1
            set(handles.axes_h,'FontAngle','italic')            
        else
            set(handles.axes_h,'FontAngle','normal')          
        end        
    end
    
    
% ================================================================
function e_fontname_Callback(hObject, eventdata, handles)
    if get(handles.rb_title,'Value')==1                  
        set(get(handles.axes_h,'Title'),'FontName',get(hObject,'String')); 
    elseif get(handles.rb_labels,'Value')==1
        set(get(handles.axes_h,'XLabel'),'FontName',get(hObject,'String'));
        set(get(handles.axes_h,'YLabel'),'FontName',get(hObject,'String'));
    else
        set(handles.axes_h,'FontName',get(hObject,'String'));
    end

    
    
% ================================================================
function e_string_Callback(hObject, eventdata, handles)          
    set(get(handles.axes_h,'Title'),'String',get(hObject,'String')); 
    
    
    
% ================================================================
function e_xlabel_Callback(hObject, eventdata, handles)       
    set(get(handles.axes_h,'XLabel'),'String',get(hObject,'String'));
    
    
        
% ================================================================
function e_ylabel_Callback(hObject, eventdata, handles)      
    set(get(handles.axes_h,'YLabel'),'String',get(hObject,'String'));
           
    
    

%   set xlim , ylim
% ================================================================
function e_xmin_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'XLim');
    aa(1) = str2num(get(hObject,'String'));
    set(handles.axes_h,'XLim',aa);
    
    clear aa
    

% ================================================================    
function e_xmax_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'XLim');
    aa(2) = str2num(get(hObject,'String'));
    set(handles.axes_h,'XLim',aa);
    
    clear aa
    
    
% ================================================================
function e_ymin_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'YLim');
    aa(1) = str2num(get(hObject,'String'));
    set(handles.axes_h,'YLim',aa);

    clear aa
    
               
% ================================================================
function e_ymax_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'YLim');
    aa(2) = str2num(get(hObject,'String'));
    set(handles.axes_h,'YLim',aa);

    clear aa
    
    
%  set ticks
% ================================================================            
function cb_xticks_Callback(hObject, eventdata, handles)
    if get(hObject,'Value')==0
        set(handles.axes_h,'XTick',[])
    else
        set(handles.axes_h,'XTickMode','auto')
    end
    
    

% ================================================================    
function cb_yticks_Callback(hObject, eventdata, handles)
    if get(hObject,'Value')==0
        set(handles.axes_h,'YTick',[])
    else
        set(handles.axes_h,'YTickMode','auto')
    end
  
    
% ================================================================
function e_xtick_step_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'XLim');
    bb = str2num(get(hObject,'String'));
    xtick = aa(1):bb:aa(2);
    set(handles.axes_h,'XTick',xtick);
        
    clear aa bb xtick
          
% ================================================================
function e_ytick_step_Callback(hObject, eventdata, handles)
    aa = get(handles.axes_h,'YLim');
    bb = str2num(get(hObject,'String'));
    ytick = aa(1):bb:aa(2);
    set(handles.axes_h,'YTick',ytick);
    
   clear aa bb ytick


% ================================================================                
function cb_xgrid_Callback(hObject, eventdata, handles)
 
    if get(hObject,'Value')==1
        set(handles.axes_h,'XGrid','on');
    else
        set(handles.axes_h,'XGrid','off');
    end
    
    
% ================================================================    
function cb_ygrid_Callback(hObject, eventdata, handles)
    if get(hObject,'Value')==1
        set(handles.axes_h,'YGrid','on');
    else
        set(handles.axes_h,'YGrid','off');
    end
    
    
get(handles.uipanel2,'Value')

% ================================================================   
% ================================================================   
function pb_aux_Callback(hObject, eventdata, handles)
    
%     set(gcf,'PaperPositionMode','auto')    
%     print -f12 -dbmp -zbuffer -r300 
    disp('not wokking yet')
    
    
    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   
%       Create functions
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



            % ===========================
            function e_fontname_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end


            % ===========================
            function e_xmin_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end


            % ===========================
            function e_xmax_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end

 
            % ===========================
            function e_ymin_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end

            
            % ===========================
            function e_ymax_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end

            
            % ===========================
            function e_xtick_step_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end



            % ===========================
            function e_ytick_step_CreateFcn(hObject, eventdata, handles)
            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end


            % ===========================
            function e_string_CreateFcn(hObject, eventdata, handles)

            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end

            function e_xlabel_CreateFcn(hObject, eventdata, handles)

            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end



            function e_ylabel_CreateFcn(hObject, eventdata, handles)

            if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                set(hObject,'BackgroundColor','white');
            end










    
    
          








