% SPIP 2017

function m_importNEWSPIPdata_Callback(hObject, eventdata, handles)
% ONLY WORKS FOR FIZEAU DATA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    set (handles.t_mappy_says,'String',{' mappy says:';'    start SPIP2017 file import...'});    
    [filename, pathname] = readSPIP2asc;
     
      if ~isempty(filename)
             handles.imported_fname = filename;
             handles.pathname = pathname;
    %          handles.flag1 = 1;
             % Update handles structure
             guidata(hObject, handles);    
             % Display message
             set (handles.t_mappy_says,'String',{' mappy says:';'    SPIP file imported'});
    %          pb_load_Callback(hObject, eventdata, handles);
        else
            % Display message
            set (handles.t_mappy_says,'String',{' mappy says:'; '   SPIP file import aborted'});
      end
% --------------------------------------------------------------------
