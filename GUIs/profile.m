%% rbp_horiz_vert_SelectionChangeFcn  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
    
    
%%  pb_manual_crosshair_Callback  
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if strcmp(get(get(handles.rbp_horiz_vert,'SelectedObject'),'Tag'),'rb_custom')   
        return
    end
    
    axes(handles.axes1)
    [x,y] = ginput(1);    
    handles.mydata.crosshair_xy = [round(x) round(y)];        
    set(handles.e_crosshair_x,'String',num2str(round(x)));
    set(handles.e_crosshair_y,'String',num2str(round(y)));       
        

    % call main profile function
    handles = refresh_axes(handles);
    
    % Update handles structure
    guidata(hObject, handles);   
    
    
%%  pb_centre_crosshair 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
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
    
     
%% e_crosshair_x_Callback    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    
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
    
    
%%  e_crosshair_y_Callback
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
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
    
    
%%  e_profile_width_Callback    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
    if get(handles.rb_custom,'Value')
        set(handles.e_profile_width,'String','1')
        disp ('for custom profiles width must be 1 pixel')
        return
    end
    
    handles = refresh_axes(handles);
   
   
   % Update handles structure
    guidata(hObject, handles);
    
    
    
    
    
%%   handles = pb_manual_profile_idx_Callback
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
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


%%  e_profile_x1_Callback
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
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

    
    
%% e_profile_x2_Callback    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
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

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    