function varargout = NEO(varargin)

                    % Begin initialization code - DO NOT EDIT
                    gui_Singleton = 1;
                    gui_State = struct('gui_Name',       mfilename, ...
                                       'gui_Singleton',  gui_Singleton, ...
                                       'gui_OpeningFcn', @NEO_OpeningFcn, ...
                                       'gui_OutputFcn',  @NEO_OutputFcn, ...
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
function NEO_OpeningFcn(hObject, ~, handles, varargin)
    
    cale = mfilename('fullpath');   
    %  'C:\Users\elt29493\Documents\MATLAB\_function_library\GUIs\NEO'
    handles.path_load = [cale(1:end-26) '_data\'];
    handles.path_import = 'Z:\';
    a = imread([cale '.jpg']);
    axes(handles.axes1)
    imagesc(a),axis off, axis equal
    set(handles.uip_ellipse_params,'Visible', 'off')
    
    handles.flag1 = 0;    
    
    % reset uicontrols
    handles = reset_uicontrols(hObject,handles);    
    
    % Display message
    set (handles.t_neo_says,'String',{'NEO says:';'   Ready for action '})
  
    % Choose default command line output for NEO
    handles.output = hObject;

    % Update handles structure
    guidata(hObject, handles);
  

% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
function varargout = NEO_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;



   
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%      *** MENU CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV


%% ------ MENU GENERAL ---------------------------------------------

% *** clear command panel  *** 
function m_clear_Callback(hObject, eventdata, handles)
    evalin('base','clear')
    
   
    
% *** clear variables from  workkspace  *** 
function m_clc_Callback(hObject, eventdata, handles)
    evalin('base','clc')



%% ------ MENU TO BASE ---------------------------------------------   


    
% *** send full analysis to workspace  *** 
function m_analysis2base_Callback(hObject, eventdata, handles)
    evalin('base','clear')
    if ~isfield(handles,'mydata')
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   Load some scans first, cupcake'})       
        return
    else
        names = fieldnames(handles.mydata);      
        for kk = 1:numel(names)            
            aa = names{kk};
            eval([names{kk} '=handles.mydata.'  names{kk} ';']);
            assignin('base',eval('aa'),eval(eval('names{kk}')));
        end
    end
    names = {};
    if ~isfield(handles,'myanalysis')
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   No analysis yet'})
        return
    else
        names = fieldnames(handles.myanalysis);
        for kk = 1:numel(names)
            aa = names{kk};
            eval([names{kk} '=handles.myanalysis.'  names{kk} ';']);
            assignin('base',eval('aa'),eval(eval('names{kk}')));
        end
    end
    info = create_info;
    assignin('base','info',info);
 

% *** send averaged analysis to workspace  *** 
function m_averaged2base_Callback(hObject, eventdata, handles)
%     evalin('base','clear')
    if ~isfield(handles,'myanalysis')||isempty(fieldnames(handles.myanalysis))
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   Run analysis first'})       
        return
    else
        names = fieldnames(handles.myanalysis.averaged);      
        for kk = 1:numel(names)            
            aa = names{kk};
            eval([names{kk} '=handles.myanalysis.averaged.'  names{kk} ';']);
            assignin('base',eval('aa'),eval(eval('names{kk}')));
        end
    end  
% add info fields  
    assignin('base','VFM',eval('handles.mydata.VFM'));
    assignin('base','instrument',eval('handles.mydata.instrument'));
    assignin('base','optic_name',eval('handles.mydata.optic_name'));
    assignin('base','namelist',eval('handles.mydata.namelist'));
    assignin('base','L',eval('handles.mydata.L'));
    assignin('base','fit_to',eval('handles.myanalysis.fit_to'));
    assignin('base','ellipse_params',eval('handles.myanalysis.ellipse_params'));
    assignin('base','active_L',eval('handles.myanalysis.active_L'));
    info = create_info;
    assignin('base','info',info);
    
       
              
% *** send fitted to workspace  *** 
function m_fitted_to_base_Callback(hObject, eventdata, handles)
    if ~isfield(handles,'mydata')
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   Run a fitting first!'})
        return
    else
        assignin('base','fitted',handles.fitted); 
    end
    

    
% *** send 'walk' structure to workspace  *** 
function m_walk2base_Callback(hObject, eventdata, handles)
    if ~isfield(handles,'walk')||isempty(fieldnames(handles.mydata))
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   Run walk analysis first'})       
        return
    else 
        assignin('base','walk',handles.walk);        
    end  


    

% *** send handles to workspace (debug mode)  *** 
function m_handles2base_Callback(hObject, eventdata, handles)
     assignin('base','handles',handles);
      
 
     
     

    
%% ------ MENU IMPORT ---------------------------------------------



% --------------------------------------------------------------------
function m_export_data_to_excel_file_Callback(hObject, eventdata, handles)



% *** send active x, slope, figure, slope error, figure error and info to workspace  *** 
function m_data4Zeiss2base_Callback(hObject, eventdata, handles)
%     evalin('base','clear')
    if ~isfield(handles,'myanalysis')||isempty(fieldnames(handles.myanalysis))
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   Run analysis first'})       
        return
    else
        % all these are needed for 'create_info' !!!
        assignin('base','namelist',eval('handles.mydata.namelist'));
        assignin('base','optic_name',eval('handles.mydata.optic_name'));
        assignin('base','instrument',eval('handles.mydata.instrument'));
        assignin('base','VFM',eval('handles.mydata.VFM'));
        assignin('base','L',eval('handles.mydata.L'));
        assignin('base','active_L',eval('handles.myanalysis.active_L'));
        assignin('base','fit_to',eval('handles.myanalysis.fit_to'));
        assignin('base','ellipse_params',eval('handles.myanalysis.ellipse_params'));
        assignin('base','slope_err_rms',eval('handles.myanalysis.averaged.slope_err_rms'));
        assignin('base','height_err_rms',eval('handles.myanalysis.averaged.height_err_rms'));
        assignin('base','roc',eval('handles.myanalysis.averaged.roc'));
        
        info = create_info;
        assignin('base','info',info);
        data = [handles.myanalysis.averaged.active_x*10^3 ...                
                handles.myanalysis.averaged.active_height*10^6 ...
                handles.myanalysis.averaged.active_phi*10^6 ...                
                handles.myanalysis.averaged.height_err*10^9 ...
                handles.myanalysis.averaged.slope_err*10^6];
        headers = {'active x [mm]', 'active height [um]', 'active slope [urad]', 'figure error [nm]', 'slope error [urad]'};    
        assignin('base','data',data);
        assignin('base','headers',headers);
    end  

    


    
%% ------ MENU IMPORT ---------------------------------------------


function m_getNOMfile_Callback(hObject, eventdata, handles)
    
    [fname, cale, pathname] = getNOMfile(handles.path_import);
    
    if ~isempty(fname)
         handles.CSVfname = fname;         
         handles.path_load = cale; 
         handles.path_import = pathname;
         
         handles.flag1 = 1;
         % Update handles structure
         guidata(hObject, handles);    
         % Display message
         set (handles.t_neo_says,'String',{' NEO says:';'    NOM file imported'});
         pb_LOAD_from_files_Callback(hObject, eventdata, handles);
    else
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:'; '   NOM file import aborted'});
    end
    
     
    
% --------------------------------------------------------------------
function m_getGTXfile_Callback(hObject, eventdata, handles)    

    [fname, pathname] = getGTXfile();
    handles.path_load = pathname;
    if ~isempty(fname)
         handles.CSVfname = fname;
         handles.flag1 = 1;
         handles.path_load = pathname;

         % Update handles structure
         guidata(hObject, handles);    
         % Display message
         set (handles.t_neo_says,'String',{' NEO says:';'   GTX file imported'})


    pb_load_data_Callback(hObject, eventdata, handles);
    else
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:'; '   GTX file import aborted'})
    end   
  
    

% --------------------------------------------------------------------
function m_getSPIPprofile_Callback(hObject, eventdata, handles)
    [fname, pathname, data_type] = readSPIPasc();
    if strcmp(data_type,'map')
       disp('Requested action aborted: selected dataset is a map')
       return
    end
    handles.path_load = pathname;
    if ~isempty(fname)
         handles.CSVfname = fname;
         handles.flag1 = 1;
         handles.path_load = pathname;

         % Update handles structure
         guidata(hObject, handles);    
         % Display message
         set (handles.t_neo_says,'String',{' NEO says:';'   SPIP file imported'})
         pb_load_data_Callback(hObject, eventdata, handles);
    else
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:'; '   SPIP file import aborted'})
    end   


    
    
%% ------ MENU EXTRAS ---------------------------------------------



% --------------------------------------------------------------------
function m_walk_analysis_Callback(hObject, eventdata, handles)

handles.joker = struct;
    if get(handles.rb_cylinder,'Value')==1
        fit_to = 'cylinder';
        params = [];         
    elseif get(handles.rb_ellipse,'Value')==1
        fit_to = 'ellipse';
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

    
    prompt = {'analysis length [mm]','edge [mm]'};
    default = {'100','5'};
    answer = inputdlg(prompt,'title',1,default);
   
    active_L = str2num(answer{1})*10^-3;
    trim = str2num(answer{2})*10^-3;
 
 % run analysis  
    x1=trim;
    xx = [];
    slope_err_rms = [];
    roc = [];
    
%     while active_L+x1 <= handles.myanalysis.active_L+trim
    while active_L+x1 <= handles.mydata.L-trim    
        output = analyse1Ddata(handles.mydata.x, handles.mydata.phi, handles.mydata.phi_roll,handles.mydata.height, [active_L x1], params);
        xx = [xx x1]; 
        slope_err_rms = [slope_err_rms; mean(output.slope_err_rms)]; 
        roc = [roc; mean(output.roc)];
        x1=x1+handles.mydata.dx;               
    end
    
    [val,idx] = min(slope_err_rms);
    fprintf('\nMinimum slope error is %f urad, at x1 = %f mm\n',val*10^6,(trim+(idx-1)*handles.mydata.dx)*10^3)
    [val,idx] = max(slope_err_rms);
    fprintf('\nMaximum slope error is %f urad, at x1 = %f mm\n',val*10^6,(trim+(idx-1)*handles.mydata.dx)*10^3)
    
    [val,idx] = min(abs(roc));
    fprintf('\nMinimum radius is %f km, at x1 = %f mm\n',val*10^-3,(trim+(idx-1)*handles.mydata.dx)*10^3)
    [val,idx] = max(abs(roc));
    fprintf('\nMaximum radius is %f km, at x1 = %f mm\n',val*10^-3,(trim+(idx-1)*handles.mydata.dx)*10^3)
    
    
% plot slope error rms values      
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    xx = xx+active_L/2;
    size(xx)
    size(slope_err_rms)
    figure(947), set(gcf,'Color','w','position',[50, 50,800, 400])
    plot(xx*10^3,slope_err_rms*10^9,'.b')
    hold on
    xlim([0 handles.mydata.L]*10^3)
    ylimz = get(gca,'ylim');
    plot([trim trim]*10^3,ylimz,  '--k', [x1+active_L x1+active_L]*10^3,ylimz,  '--k')
    hold off
    ylabel('Slope error rms[nrad]','Fontsize',12,'FontWeight','bold')
    xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
   
    
   figure(948), set(gcf,'Color','w','position',[50, 50,800, 400])
    plot(xx*10^3,abs(roc),'.b')
    hold on
    xlim([0 handles.mydata.L]*10^3)
    ylimz = get(gca,'ylim');
    plot([trim trim]*10^3,ylimz,  '--k', [x1+active_L x1+active_L]*10^3,ylimz,  '--k')
    hold off
    ylabel('Radius of curvature [m]','Fontsize',12,'FontWeight','bold')
    xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
    
    
   figure(949), set(gcf,'Color','w','position',[50, 50,800, 400])
    plot(xx*10^3,1./roc,'.b')
    hold on
    xlim([0 handles.mydata.L]*10^3)
    ylimz = get(gca,'ylim');
    plot([trim trim]*10^3,ylimz,  '--k', [x1+active_L x1+active_L]*10^3,ylimz,  '--k')
    hold off
    ylabel('Curvature [m^-^1]','Fontsize',12,'FontWeight','bold')
    xlabel('Length [mm]','Fontsize',12,'FontWeight','bold')
    
handles.walk.slope_err = slope_err_rms;
handles.walk.roc = roc;
handles.walk.xx = xx;
handles.walk.active_L = active_L;
handles.walk.x1 = trim;
handles.walk.x2 = x1-handles.mydata.dx+active_L;
% Update handles structure
guidata(hObject, handles);    
   

 
% *** resets GUI  *** 
function m_reset_Callback(hObject, eventdata, handles)
    handles = reset_uicontrols(hObject,handles);
    handles = reset_handles(hObject,handles);  



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




%% :::::::::::::::::   Current DATA   :::::::::::::::::::::::::::::::::::::



% ************   load profile data from files  ************
function pb_LOAD_from_files_Callback(hObject, eventdata, handles)
    pathN = handles.path_load;
    
% check if there's all ready a namelist waiting to be loaded  
    if handles.flag1 == 1;
        pathN = mfilename('fullpath');  
    %  'C:\Users\elt29493\Documents\MATLAB\_function_library\GUIs\NEO'
        pathN = [pathN(1:end-26) '_data\'];
        fileN = handles.CSVfname;        
    else
        [fileN,pathN] = uigetfile([pathN '\*.mat'],'MultiSelect','on');    
    end
    
% convert namelist to cell, even if singleton    
    if iscell(fileN)
        fileN = sort(fileN);
        handles.path_load = pathN;
    elseif fileN == 0           
        disp('user abort');
        return
    else
        fileN = {fileN};
        handles.path_load = pathN;
    end
    
% if there is a valid file list to be loaded, reset gui and flush data
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    handles = reset_uicontrols(hObject,handles);
    handles = reset_handles(hObject,handles);    
   
% Proceed with load
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% fill mydata structure

    for kk = 1:numel(fileN)      
        fileN
        load([pathN fileN{kk}])
        handles.mydata.namelist{kk} = fileN{kk};
%         if handles.flag1
%             handles.mydata.namelist{kk} = fileN{kk};
%         else
%             handles.mydata.namelist{kk} = fileN{kk}(1:end-4);
%         end 
%       
        if exist('phi_roll','var')
            handles.mydata.x(:,kk) = x;
            handles.mydata.phi(:,kk) = phi;
            handles.mydata.phi_roll(:,kk) = phi_roll;
            handles.mydata.instrument = 'NOM';   
        elseif exist('instrument','var')
            handles.mydata.x(:,kk) = x;
            handles.mydata.height(:,kk) = data;
            VFM = 'n';
            handles.mydata.instrument = 'FIZ';
        else
            handles.mydata.x(:,kk) = x';            
            handles.mydata.height(:,kk) = height';
            handles.mydata.instrument = 'GTX';
            
        end    
    end    
       
% Run preanalysis and display info
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    

% create dummy phi_roll if necessary  
    if ~strcmp(handles.mydata.instrument, 'NOM')
        handles.mydata.phi_roll = zeros(size(handles.mydata.x));
        output = preanalysis1d('GTX',handles.mydata.x,handles.mydata.height,handles.mydata.phi_roll);
    else
        output = preanalysis1d('NOM',handles.mydata.x,handles.mydata.phi,handles.mydata.phi_roll);
    end
    
    handles.mydata.height = output.height;
    handles.mydata.phi = output.phi;
    handles.mydata.phi_roll = output.phi_roll;
    handles.mydata.x = output.x;   
    handles.mydata.dx = output.dx;    
    handles.mydata.optic_name = optic_name;
    handles.mydata.L = output.L;
    handles.mydata.VFM = VFM;
    handles.mydata.x_scan = output.x_scan;
    handles.mydata.x_offset = output.x_offset;
    handles.mydata.x_substrate = output.x_scan;
%     handles.mydata.x = handles.mydata.x - repmat(handles.mydata.x(1,:),[size(handles.mydata.x,1) 1]);
    clear output
    
 % set uicontrols   
    set(handles.lb_loaded_datasets,'Value',1,'String',handles.mydata.namelist);  
    set(handles.uip_INFO,'Title',[handles.mydata.optic_name ' - INFO'])
    set(handles.t_instrument,'String',handles.mydata.instrument); 
    set(handles.t_optic_length,'String',handles.mydata.L*10^3);
    if VFM == 'y'
        set(handles.t_geometry,'String','VF')
    else
        set(handles.t_geometry,'String','HF')
    end
    set(handles.t_neo_says,'String',{' NEO says:';['  Scan start: x1 = ' num2str(x(1)*1000) 'mm'];...
        ['         end: x2 = ' num2str(x(end)*1000) 'mm']});
    set(handles.e_offset_xc,'String','0');    
    set(handles.cb_offset_analysis,'Value',0);
    
    set(handles.e_x1_substrate,'String',str2num(num2str((handles.mydata.x_scan(1))*1000)));
    set(handles.e_x2_substrate,'String',str2num(num2str((handles.mydata.x_scan(2))*1000)));
    
    
    disp('done load')
    handles.flag1 = 0;
      
% Update handles structure
guidata(hObject, handles);    
    



% ************   load profile data from base  ************
function pb_LOAD_from_base_Callback(hObject, eventdata, handles)

    % pas de gardefou!! load EVERYTHING from base workspace. 
    evalin('base','save dummy');
    aa = load('dummy.mat');  
    delete('dummy.mat');

% if there is a valid file list to be loaded, reset gui and flush data
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    handles = reset_uicontrols(hObject,handles);
    handles = reset_handles(hObject,handles);    
   
% Proceed with load
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% fill mydata structure

    kk = 1;
    if ~isfield(aa,'instrument')


        prompt = {'Which instrument? (NOM/FIZ/GTX)'};
        default = {'NOM'};
        answer = inputdlg(prompt,'title',1,default);

        if isempty(answer)
            clear
            disp('user abort')
            return
        end
        aa.instrument =   answer{1};

    end
        
    handles.mydata.namelist{kk} = aa.filename;
    switch aa.instrument
        case 'NOM'
            handles.mydata.x(:,kk) = aa.x;
            handles.mydata.phi(:,kk) = aa.phi;
            handles.mydata.phi_roll(:,kk) = aa.phi_roll;
            handles.mydata.instrument = 'NOM';
            VFM = aa.VFM;
        case 'FIZ'
            handles.mydata.x(:,kk) = aa.x;
            handles.mydata.height(:,kk) = aa.height;
            VFM = 's';
            handles.mydata.instrument = 'FIZ';
        case 'GTX'
            handles.mydata.x(:,kk) = aa.x';
            handles.mydata.height(:,kk) = aa.height';
            handles.mydata.instrument = 'GTX';
            VFM = 'u'
        otherwise
            return
    end
    
 
% Run preanalysis and display info
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++    

% create dummy phi_roll if necessary  
    if ~strcmp(handles.mydata.instrument, 'NOM')
        handles.mydata.phi_roll = zeros(size(handles.mydata.x));
        output = preanalysis1d('GTX',handles.mydata.x,handles.mydata.height,handles.mydata.phi_roll);
    else
        output = preanalysis1d('NOM',handles.mydata.x,handles.mydata.phi,handles.mydata.phi_roll);
    end
    
    handles.mydata.height = output.height;
    handles.mydata.phi = output.phi;
    handles.mydata.phi_roll = output.phi_roll;
    handles.mydata.x = output.x;   
    handles.mydata.dx = output.dx; %#ok<*COLND>    
    handles.mydata.optic_name = aa.optic_name;
    handles.mydata.L = output.L;
    handles.mydata.VFM = VFM;
    handles.mydata.x = handles.mydata.x - repmat(handles.mydata.x(1,:),[size(handles.mydata.x,1) 1]);
    clear output aa
    
 % set uicontrols   
    set(handles.lb_loaded_datasets,'Value',1,'String',handles.mydata.namelist);  
    set(handles.uip_INFO,'Title',[handles.mydata.optic_name ' - INFO'])
    set(handles.t_instrument,'String',handles.mydata.instrument); 
    set(handles.t_optic_length,'String',handles.mydata.L*10^3);
    if VFM == 'y'
        set(handles.t_geometry,'String','VF')
    else
        set(handles.t_geometry,'String','HF')
    end
    set(handles.t_neo_says,'String',{' NEO says:';['  Scan start: x1 = ' num2str(handles.mydata.x(1)*1000) 'mm'];...
        ['         end: x2 = ' num2str(handles.mydata.x(end)*1000) 'mm']});
    
    set(handles.e_offset_xc,'String','0');    
    set(handles.cb_offset_analysis,'Value',0);
    
    disp('done load')
    handles.flag1 = 0;
      
% Update handles structure
guidata(hObject, handles);
 


% ************   sort current data  ************
function pb_sort_data_Callback(hObject, eventdata, handles)
    
    aa = Sorter(handles.mydata.namelist);
    
    for ii = 1:numel(aa)       
        index(ii) = find(strcmp(handles.mydata.namelist, aa{ii}));        
    end

    set(handles.lb_loaded_datasets,'Value',1,'String',aa) 
    
    % rearrange all data
    handles.mydata.namelist = aa;    
    handles.mydata.x = handles.mydata.x(:,index);
    handles.mydata.phi = handles.mydata.phi(:,index);
    handles.mydata.height = handles.mydata.height(:,index);
    handles.mydata.phi_roll = handles.mydata.phi_roll(:,index);
    
    % Update handles structure
    guidata(hObject, handles); 
      
    
    
% ************   Save current data  ************    
function pb_save_data_Callback(hObject, eventdata, handles)  
    if get(handles.rb_cylinder,'Value')==1
        fit_to = 'cylinder';
    elseif  get(handles.rb_ellipse,'Value')==1
        fit_to = 'ellipse';
    end
    filename = [strrep(handles.mydata.optic_name, ' ', '-') '_' get(handles.e_active_length,'String') 'mm_' fit_to '.mat'];
    prompt = {'Save averaged/all (avg/all)','File name'};
    default = {'avg',filename};
    answer = inputdlg(prompt,'title',1,default);

    if isempty(answer)
        clear
        disp('user abort')
        return
    end

    machin =  answer{1};
    filename = answer{2};
    
    evalin('base','clear') 
    if strcmp(machin,'avg')
        m_averaged2base_Callback(hObject, eventdata, handles)
    elseif strcmp(machin,'all')
        m_analysis2base_Callback(hObject, eventdata, handles)
    else
        disp('wrong input. save aborted')
    end    

    evalin('base',['save(''' filename ''')']) 
    
 
        % Update handles structure
    guidata(hObject, handles);  
    
          




function e_x1_substrate_Callback(hObject, eventdata, handles)




function e_x2_substrate_Callback(hObject, eventdata, handles)

    
    
    
    
    
%% ::::::::::::::::: CURRENT ANALYSIS :::::::::::::::::::::::::::::::::::::   


% ************  Analysis settings: fit to (cylinder or ellipse)  ************
function rb_fit_to_SelectionChangeFcn(hObject, eventdata, handles)
    if strcmp(get(hObject,'String'),'cylinder')     
        set(handles.uip_ellipse_params,'Visible', 'off')        
        set(handles.uip_nomi,'Visible', 'on')
    elseif  strcmp(get(hObject,'String'),'ellipse')
        set(handles.uip_nomi,'Visible', 'off')
        set(handles.uip_ellipse_params,'Visible', 'on')        
    else   
        set(handles.uip_ellipse_params,'Visible', 'off')        
        set(handles.uip_nomi,'Visible', 'on')
    end
    
    
    
% ************  Perform new analysis  ************
function pb_analyse_Callback(hObject, eventdata, handles)
    
% destroy previous analysis
    handles.myanalysis = struct;    
   
% check analysis parameters     
    active_L = str2num(get(handles.e_active_length,'String'))*10^-3;
    handles.myanalysis.active_L = active_L;
    
    if get(handles.rb_cylinder,'Value')==1
        fit_to = 'cylinder';
        params = [];         
    elseif get(handles.rb_ellipse,'Value')==1
        fit_to = 'ellipse';
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

% check if analysis length is centred or not
    if get(handles.cb_offset_analysis,'Value')==0
        xc = nan;
    else
        xc = str2num(get(handles.e_offset_xc,'String'))/1000;
    end    
 
 % run analysis   
    output = analyse1Ddata(handles.mydata.x, handles.mydata.phi, handles.mydata.phi_roll,handles.mydata.height, [active_L xc], params);
    
    if strcmp(output.message(1:5),'ERROR')
        disp('*** Analysis failed. Some sort of error')
    else    
        handles.myanalysis.active_x = output.active_x;
        handles.myanalysis.active_phi = output.active_phi;
        handles.myanalysis.active_phi_roll = output.active_phi_roll;
        handles.myanalysis.active_height = output.active_height;    

        handles.myanalysis.height_err = output.height_err;
        handles.myanalysis.slope_err = output.slope_err;    
        handles.myanalysis.slope_err_rms = output.slope_err_rms;
        handles.myanalysis.height_err_rms = output.height_err_rms;
        handles.myanalysis.roc = output.roc;
        handles.myanalysis.fit_to = fit_to;
        handles.myanalysis.active_x_offset = output.active_x_offset;

        % update uicontrols
        set(handles.rb_plot_all,'Value',1)     
        
        % set info display
        set(handles.t_optic_length,'String',handles.mydata.L*10^3);
        set(handles.t_active_length,'String',num2str((active_L)*10^3));
        set(handles.t_RoC,'String',num2str(mean(handles.myanalysis.roc))); 
        set(handles.t_slope_err_rms,'String',num2str(mean(handles.myanalysis.slope_err_rms)*10^6));
        set(handles.t_fig_err_rms,'String',num2str(mean(handles.myanalysis.height_err_rms)*10^9));

        % Display scan edges
        set (handles.t_neo_says,'String',{' NEO says:';['   Analysis done'];['   Optic was fit to ' fit_to]})

        handles = m_average_scans_Callback(hObject, eventdata, handles);

        % Update handles structure
        guidata(hObject, handles); 

        % look for best fit ellipse
        if get(handles.rb_ellipse,'Value')==1
            if get(handles.cb_tweak_ellipse_theta,'Value')    
                if get(handles.cb_tweak_ellipse_Q,'Value')
                    disp('tweak Q and theta') 
%                     m_best_fit_ellipse_doubletweak_theta_Callback(hObject, eventdata, handles);
                    [best_theta, min_slope_err] = tweak_Q_and_theta_ellipse(handles.myanalysis.averaged.active_x,  handles.myanalysis.averaged.active_phi, params);
                else
                    disp('tweak theta') 
%                     m_best_fit_ellipse_tweak_theta_Callback(hObject, eventdata, handles);
                    [best_theta, min_slope_err] = tweak_theta_ellipse(handles.myanalysis.averaged.active_x,  handles.myanalysis.averaged.active_phi, params);
                end
                                    
            elseif get(handles.cb_tweak_ellipse_Q,'Value')
                disp('tweak Q')
                [best_theta, min_slope_err] = tweak_Q_ellipse(handles.myanalysis.averaged.active_x,  handles.myanalysis.averaged.active_phi, params);
            else
                disp('don''t tweak')
            end
        end
    end
    
    
    
% ************ Ellipse parameters ************
function cb_sign_ellipse_Callback(hObject, eventdata, handles)
    if get(hObject,'Value')==1
        1
        set(hObject,'String','+1')
    else
        1
        set(hObject,'String','-1')
    end
      
    
   
%% ::::::::::::::::: DISPLAY :::::::::::::::::::::::::::::::::::::   



% ************ All / selected ************
function rb_show_all_or_selected_SelectionChangeFcn(hObject, eventdata, handles)
    if ~isfield(handles,'myanalysis')
        return
    end
    
    if strcmp(get(hObject,'String'),'All')    
        if isfield(handles.myanalysis,'roc')   
            set(handles.t_RoC,'String',num2str(mean(handles.myanalysis.roc)));
        else 
            set(handles.t_RoC,'String','---');
        end
        
        set(handles.t_slope_err_rms,'String',num2str(mean(handles.myanalysis.slope_err_rms)*10^6));
        set(handles.t_fig_err_rms,'String',num2str(mean(handles.myanalysis.height_err_rms)*10^9));
%         set(handles.lb_loaded_datasets,'Value',1);
    elseif  strcmp(get(hObject,'String'),'Selected')  % show selected
        idx = get(handles.lb_loaded_datasets,'Value');    
        if isfield(handles.myanalysis,'roc')   
            set(handles.t_RoC,'String',num2str(mean(handles.myanalysis.roc(idx))));
        else 
            set(handles.t_RoC,'String','---');
        end
        
        set(handles.t_slope_err_rms,'String',num2str(mean(handles.myanalysis.slope_err_rms(idx))*10^6));
        set(handles.t_fig_err_rms,'String',num2str(mean(handles.myanalysis.height_err_rms(idx))*10^9));  
    else % show average
          
        if isfield(handles.myanalysis.averaged,'roc')   
            set(handles.t_RoC,'String',num2str(mean(handles.myanalysis.averaged.roc)));
        else 
            set(handles.t_RoC,'String','---');
        end
        
        set(handles.t_slope_err_rms,'String',num2str(mean(handles.myanalysis.averaged.slope_err_rms)*10^6));
        set(handles.t_fig_err_rms,'String',num2str(mean(handles.myanalysis.averaged.height_err_rms)*10^9));  
    end  
    
% Update handles structure
guidata(hObject, handles); 
 
 

% ************ Plot figure/figure error/Slope error/Twist  ************
function pb_plot_Callback(hObject, eventdata, handles)  
    
    if ~isfield(handles,'myanalysis')
        disp('Run the analysis first, you clot!')
        return
    end
    
    
    % check if 'all' / 'selected' / or'averaged'
    if get(handles.rb_plot_averaged,'Value')==1
        idx = -1;
    elseif get(handles.rb_plot_selected,'Value')==1
        idx = get(handles.lb_loaded_datasets,'Value');
    else
        idx = 1:numel(handles.myanalysis.slope_err_rms);
    end
    
    co = [0 0.25 1;   0 0.7 0;   1 0 0;   0 0.75 1;   1 0.5 0;   0.75 0 0.75;   0.25 0 0.75;   0.75 0.25 0];
    trim = (handles.mydata.L - handles.myanalysis.active_L)/2;
    x1 = handles.myanalysis.active_x(1,1)-trim;
    x2 = handles.myanalysis.active_x(end,1)+trim;
    
    
    if get(handles.cb_plot_figure,'Value')    
        if ~ishandle(11)
            figure(11),   set(gcf,'color','w',  'Position', [50, 200, 800, 400]);   
        else
            figure(11)
        end       
        set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');      
        if idx == -1
            plot(handles.myanalysis.averaged.active_x*10^3, 10^6*handles.myanalysis.averaged.active_height,'b','LineWidth',1.5) 
        else
            plot(handles.myanalysis.active_x(:,idx)*10^3, 10^6*handles.myanalysis.active_height(:,idx),'LineWidth',1.5)     
        end
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Figure [um]','Fontsize',12,'FontWeight','bold') 
        xlim([x1   x2]*10^3)
    end
    drawnow
    if get(handles.cb_plot_slope_err,'Value')   
        if ~ishandle(12)
            figure(12),   set(gcf,'color','w',  'Position', [100, 150, 800, 400]);   
        else
            figure(12)
        end     
        set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');      
        if idx == -1
            plot(handles.myanalysis.averaged.active_x*10^3, 10^6*handles.myanalysis.averaged.slope_err,'b','LineWidth',1.5)  
        else
            plot(handles.myanalysis.active_x(:,idx)*10^3, 10^6*handles.myanalysis.slope_err(:,idx),'LineWidth',1.5)    
        end
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Slope error [urad]','Fontsize',12,'FontWeight','bold') 
        xlim([x1 x2]*10^3)
    end
    drawnow
    if get(handles.cb_plot_figure_err,'Value') 
        if ~ishandle(13)
            figure(13),   set(gcf,'color','w',  'Position', [150, 100, 800, 400]);   
        else
            figure(13)
        end
        set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on'); 
        if idx == -1
            plot(handles.myanalysis.averaged.active_x*10^3, 10^9*handles.myanalysis.averaged.height_err,'b','LineWidth',1.5)     
        else
            plot(handles.myanalysis.active_x(:,idx)*10^3, 10^9*handles.myanalysis.height_err(:,idx),'LineWidth',1.5) 
        end
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Figure error [nm]','Fontsize',12,'FontWeight','bold') 
        xlim([x1 x2]*10^3)
    end
    drawnow
    if get(handles.cb_plot_twist,'Value')    
        if ~ishandle(14)
            figure(14),   set(gcf,'color','w',  'Position', [200, 50, 800, 400]);   
        else
            figure(14)
        end   
        set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');  
        if idx == -1
            plot(handles.myanalysis.averaged.active_x*10^3, 10^6*handles.myanalysis.averaged.active_phi_roll,'b','LineWidth',1.5)    
        else
            plot(handles.myanalysis.active_x(:,idx)*10^3, 10^6*handles.myanalysis.active_phi_roll(:,idx),'LineWidth',1.5)             
        end
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Twist angle [urad]','Fontsize',12,'FontWeight','bold') 
        xlim([x1 x2]*10^3)
    end
    drawnow
    % specials
    if get(handles.cb_plot_radius_drift,'Value')    
        if ~ishandle(15)
            figure(15),   set(gcf,'color','w',  'Position', [100, 100, 800, 400]);   
        else
            figure(15)
        end      
        plot(handles.myanalysis.roc,'ob','LineWidth',2)    
        ylabel('Radius of curvature [m]','Fontsize',12,'FontWeight','bold') 
        plot(1./handles.myanalysis.roc,'ob','LineWidth',2)              
        ylabel('Curvature [m^-^1]','Fontsize',12,'FontWeight','bold') 
        xlabel('Scan no','Fontsize',12,'FontWeight','bold')
    end
    drawnow  
    if get(handles.cb_plot_prfs,'Value')   
        if get(handles.cb_prf_type2,'Value')  
            prfs = handles.myanalysis.active_height(:,2:end) - repmat(handles.myanalysis.active_height(:,1),[1 size(handles.myanalysis.active_height,2)-1]);
        else
            prfs = diff(handles.myanalysis.active_height,[],2);
        end
        x = repmat(handles.myanalysis.active_x(:,1),[1 size(prfs,2)]) ;
        
        if ~ishandle(16)
            figure(16),   set(gcf,'color','w',  'Position', [100, 100, 800, 400]);   
        else
            figure(16)
        end    
        set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');      
        plot(x*10^3, 10^6*prfs,'LineWidth',2)      
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('PRFs [um]','Fontsize',12,'FontWeight','bold') 
        xlim([x1 x2]*10^3)
    end
       
    
        
% ************ closes all plot windows  ************
function pb_close_figs_Callback(hObject, eventdata, handles) 
    
    all_figs = findobj(0, 'type', 'figure');
    
    for kk = 1:size(all_figs,1)
        h = all_figs(kk).Number;
        if isnumeric(h) && numel(h)>0         
            if sum((h==[11:16]))>0
                close(h)
            end
        end
    end
    
    
    
%% ::::::::::::::::: REMOVE POLYNOMIAL :::::::::::::::::::::::::::::::::::::   
    

% ************  Fit polynomial  ************
function pb_fit_polynomial_Callback(hObject, eventdata, handles)
    if isempty(fieldnames(handles.myanalysis))        
        % Display message
        set (handles.t_neo_says,'String',{'NEO says:'; '   Run the analysis first, you clot!'}) 
        return
    end

% applied to the average
    
    idx = get(handles.lb_loaded_datasets,'Value');
    deg = str2num(get(handles.e_polyfit_degree,'String'));   
    fit_target = get(handles.pu_polyfit_target,'Value');
    
%     figure(12),   set(gcf,'color','w',  'Position', [100, 100, 650, 450]);        
%         set(gca, 'NextPlot', 'replacechildren','Box','on');      
%         xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        
    switch fit_target
        case 1 %slope error
            % Display message
            ss = get (handles.t_neo_says,'String');
            set (handles.t_neo_says,'String',{'NEO says:'; ['   fitted slope error to a ' num2str(deg) ' degree polynomial']}) 
            fprintf('\n fitted slope error to a %d degree polynomial: \n', deg)

            fitcoef4 = polyfit(handles.myanalysis.averaged.active_x, handles.myanalysis.averaged.slope_err,deg);
            handles.fitted.fitted4 = polyval(fitcoef4,handles.myanalysis.averaged.active_x);

            handles.fitted.slope_err = handles.myanalysis.averaged.slope_err - handles.fitted.fitted4;
            handles.fitted.slope_err_rms = sqrt(sum((handles.fitted.slope_err-mean(handles.fitted.slope_err)).^2)/(numel(handles.fitted.slope_err)-1));

            figure(16),   set(gcf,'color','w',  'Position', [100, 150, 800, 400]);               
                plot(handles.myanalysis.averaged.active_x*10^3, 10^6*handles.myanalysis.averaged.slope_err,...
                     handles.myanalysis.averaged.active_x*10^3, 10^6*handles.fitted.slope_err,'LineWidth',2)            
                ylabel('Slope error [urad]','Fontsize',12,'FontWeight','bold')
                xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')        
                
%                 fprintf('fitted figure error is:  %g  nm RMS \n', handles.fitted.height_err_rms*10^9)
                fprintf('\n fitted slope error is:   %g  urad RMS \n', handles.fitted.slope_err_rms*10^6)
            
            
        case 2 % figure
            fprintf('\n fitted figure to a %d degree polynomial: \n', deg)

            fitcoef4 = polyfit(handles.myanalysis.averaged.active_x, handles.myanalysis.averaged.active_height,deg);
            handles.fitted.fitted4 = polyval(fitcoef4,handles.myanalysis.averaged.active_x);

            handles.fitted.height = handles.myanalysis.averaged.active_height - handles.fitted.fitted4;
            
            figure(16),   set(gcf,'color','w',  'Position', [100, 150, 800, 400]);                         
            plot(handles.myanalysis.averaged.active_x*10^3, 10^6*handles.myanalysis.averaged.active_height,...
                 handles.myanalysis.averaged.active_x*10^3, 10^6*handles.fitted.height,'LineWidth',2)            
            ylabel('Figure [um]','Fontsize',12,'FontWeight','bold')
            xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')        
            

        case 3 % figure error
            fprintf('\n fitted figure error to a %d degree polynomial: \n', deg)

            fitcoef4 = polyfit(handles.myanalysis.averaged.active_x, handles.myanalysis.averaged.height_err,deg);
            handles.fitted.fitted4 = polyval(fitcoef4,handles.myanalysis.averaged.active_x);

            handles.fitted.height_err = handles.myanalysis.averaged.height_err - handles.fitted.fitted4;
            handles.fitted.height_err_rms = sqrt(sum((handles.fitted.height_err-mean(handles.fitted.height_err)).^2)/(numel(handles.fitted.height_err)-1));
          
            figure(16),   set(gcf,'color','w',  'Position', [100, 150, 800, 400]);                          
            plot(handles.myanalysis.averaged.active_x*10^3, 10^9*handles.myanalysis.averaged.height_err,...
                 handles.myanalysis.averaged.active_x*10^3, 10^9*handles.fitted.height_err,'LineWidth',2)            
            ylabel('Figure error [nm]','Fontsize',12,'FontWeight','bold')
            xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')        
            
            fprintf('\n fitted figure error is:  %g  nm RMS \n', handles.fitted.height_err_rms*10^9)
            
    end
   
    % Update handles structure
    guidata(hObject, handles); 
        

    


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%      END OF  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
%      *** EMBEDDED FUNCTIONS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



function handles = reset_uicontrols(hObject,handles)

    set(handles.lb_loaded_datasets,'Value',1,'String',''); 
    
    % reset radiobuttons   
    set(handles.rb_cylinder,'Value',1)
    
    set(handles.uip_ellipse_params,'Visible', 'off')        
    set(handles.uip_nomi,'Visible', 'on')
    
    set(handles.rb_plot_all,'Value',1)
    
    % reset listbox
    set(handles.lb_loaded_datasets,'String','');
    
    % reset checkboxes
    set(handles.cb_plot_figure,'Value',0);
    set(handles.cb_plot_figure_err,'Value',0);
    set(handles.cb_plot_slope_err,'Value',0);
    set(handles.cb_plot_twist,'Value',0);
    set(handles.cb_plot_radius_drift,'Value',0);
    set(handles.cb_plot_prfs,'Value',0);
    set(handles.cb_tweak_ellipse_theta,'Value',0);
    set(handles.cb_tweak_ellipse_Q,'Value',0);
    
    
    set(handles.cb_sign_ellipse,'String','-1');
    set(handles.cb_offset_analysis,'Value',0);
    
    % reset edit controls
    set(handles.e_active_length,'String','');
    set(handles.e_offset_xc,'String','');
    
    % reset info textboxes
    set(handles.uip_INFO,'Title','OPTIC - INFO'); 
    set(handles.t_instrument,'String','---');
    set(handles.t_geometry,'String','---');
    set(handles.t_optic_length,'String','---');
    set(handles.t_active_length,'String','---');
    set(handles.t_RoC,'String','---');
    set(handles.t_slope_err_rms,'String','---');
    set(handles.t_fig_err_rms,'String','---');
    
    
    % Update handles structure
    guidata(hObject, handles);   

    
    
function handles = reset_handles(hObject, handles)
    handles.flag1 = 0;
    
%  flush previous data
    handles.mydata = struct;
    handles.myanalysis = struct;
    handles.fitted = struct;    
    
% Update handles structure
    guidata(hObject, handles);     
    
    

function handles = m_average_scans_Callback(hObject, eventdata, handles)   
   
    if ~isfield(handles,'myanalysis')  
        % Display message
        set (handles.t_neo_says,'String',{' NEO says:';'   Can''t average, no analysis yet'})
        return
    elseif isempty(fieldnames(handles.myanalysis))
        set (handles.t_neo_says,'String',{' NEO says:';'   Can''t average, no analysis yet'})
        return
    end
    
    mm.phi = mean(handles.mydata.phi,2);
    mm.phi_roll = mean(handles.mydata.phi_roll,2);
    mm.height = mean(handles.mydata.height,2);
    mm.x = handles.mydata.x(:,1); 
    
    mm.active_phi = mean(handles.myanalysis.active_phi,2);
    mm.active_phi_roll = mean(handles.myanalysis.active_phi_roll,2);
    mm.active_x = handles.myanalysis.active_x(:,1); 

    %% calculate figure:
    mm.active_height = intnom(mm.active_phi,handles.mydata.dx);

    % ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    %% do the fitting  
    fitted = fitnom(mm.active_x,mm.active_phi,handles.myanalysis.fit_to,handles.myanalysis.ellipse_params);
    mm.slope_err = fitted.slope_err;
    mm.slope_err_rms = fitted.slope_err_rms;
    mm.height_err = fitted.height_err;
    mm.height_err_rms = fitted.height_err_rms;
    if isfield(fitted,'RoC')
        mm.roc = fitted.RoC;
    end       

    handles.myanalysis.averaged = mm;

% Update handles structure
guidata(hObject, handles);    



% --------------------------------------------------------------------
function m_best_fit_ellipse_tweak_theta_Callback(hObject, eventdata, handles)
    
    spec_theta = str2num(get(handles.e_theta_ellipse,'String'));

    if str2num(get(handles.e_theta_ellipse,'String'));
        
        P = str2num(get(handles.e_P_ellipse,'String'));
        Q = str2num(get(handles.e_Q_ellipse,'String'));
        if get(handles.cb_sign_ellipse,'Value')
            semn =  1;
        else
            semn = -1;
        end

        step_theta = 0.003;

        for ii = 1:3

            step_theta = step_theta/100;
%             figure(999), set(gcf,'color','w',  'Position', [300,100, 600, 700]);
            for kk = 1:101
                theta = spec_theta + (kk-51)*step_theta;
                thetas(kk) = theta;
                %         RoC_ellipse = (2*P*Q)/((P+Q)*sin(theta));

                slope_ideal = semn*( ((P+Q)*sin(theta)) / ((P+Q)^2-((P-Q)^2)*(sin(theta)^2)) )...
                    *( (P-Q)*cos(theta) - sqrt(P*Q)*(((P-Q)*cos(theta)-2*semn*handles.myanalysis.averaged.active_x)...
                    ./(sqrt(P*Q+((P-Q)*cos(theta))*(semn*handles.myanalysis.averaged.active_x)-handles.myanalysis.averaged.active_x.^2))));

                phi_norm = handles.myanalysis.averaged.active_phi-mean(handles.myanalysis.averaged.active_phi);
                slope_err = (phi_norm - slope_ideal);  % micro radians
                slope_err = slope_err - mean(slope_err);
                slope_errs_rms(kk) = sqrt(sum((slope_err-mean(slope_err)).^2)/(numel(slope_err)-1));
            end

            [min_slope_err min_idx] = min(abs(slope_errs_rms));
            change = abs(thetas(min_idx)-spec_theta)*100/spec_theta;

            theta_min = thetas(min_idx);

            
            assignin('base',['thetas' num2str(ii)],thetas*1000000);
            assignin('base',['slope_errs_rms' num2str(ii)],slope_errs_rms*1000000);

% 
%             figure(999),
%             subplot(3,1,ii),    
%             plot(thetas*10^6,slope_errs_rms*10^6,'.b')
%             hold on
%             plot(thetas(min_idx)*10^6,   min_slope_err*10^6, 'or','LineWidth',2)
%             hold off
%             xlim([thetas(1) thetas(end)]*10^6)
%             ylabel('slope err rms [urad]','Fontsize',12,'FontWeight','bold')

            spec_theta = thetas(min_idx);
            thetas = [];

        end
        best_theta = spec_theta;
        spec_theta = str2num(get(handles.e_theta_ellipse,'String'));
        change = abs(best_theta-spec_theta)*100/spec_theta;
        fprintf('\nMinimum slope error = %.6furad for:\n  * new theta = %.9f (changes by: %.3f percent)\n', min_slope_err*10^6, best_theta, change)

    end  
%     figure(999)
%     xlabel('theta [urad]','Fontsize',12,'FontWeight','bold')
        
    
    
    
function m_best_fit_ellipse_doubletweak_theta_Callback(hObject, eventdata, handles)
    
   
    spec_theta = str2num(get(handles.e_theta_ellipse,'String'));

    if str2num(get(handles.e_theta_ellipse,'String'));
        
        P = str2num(get(handles.e_P_ellipse,'String'));
        Q = str2num(get(handles.e_Q_ellipse,'String'));
        if get(handles.cb_sign_ellipse,'Value')
            semn =  1;
        else
            semn = -1;
        end

        step_theta = 0.003;
        Qstep = Q/100/10;
        
        for jj = 1:51
            Q_crt = Q+(jj-26)*Qstep;
            theta_centre = spec_theta;
            step_theta = spec_theta;
        
        for ii = 1:3

            step_theta = step_theta/100;
%             figure(999), set(gcf,'color','w',  'Position', [300,100, 600, 700]);
            for kk = 1:101
                theta = theta_centre + (kk-51)*step_theta;
                thetas(kk) = theta;
                %         RoC_ellipse = (2*P*Q)/((P+Q)*sin(theta));

                slope_ideal = semn*( ((P+Q_crt)*sin(theta)) / ((P+Q_crt)^2-((P-Q_crt)^2)*(sin(theta)^2)) )...
                    *( (P-Q_crt)*cos(theta) - sqrt(P*Q_crt)*(((P-Q_crt)*cos(theta)-2*semn*handles.myanalysis.averaged.active_x)...
                    ./(sqrt(P*Q_crt+((P-Q_crt)*cos(theta))*(semn*handles.myanalysis.averaged.active_x)-handles.myanalysis.averaged.active_x.^2))));

                phi_norm = handles.myanalysis.averaged.active_phi-mean(handles.myanalysis.averaged.active_phi);
                slope_err = (phi_norm - slope_ideal);  % micro radians
                slope_err = slope_err - mean(slope_err);
                slope_errs_rms(kk) = sqrt(sum((slope_err-mean(slope_err)).^2)/(numel(slope_err)-1));
            end

            [min_slope_err min_idx] = min(abs(slope_errs_rms));
            change = abs(thetas(min_idx)-spec_theta)*100/spec_theta;

            theta_min = thetas(min_idx);

            
            assignin('base',['thetas' num2str(ii)],thetas*1000000);
            assignin('base',['slope_errs_rms' num2str(ii)],slope_errs_rms*1000000);

            theta_centre = thetas(min_idx);
            thetas = [];
        end
        
        best_thetas(jj) = theta_centre;
        min_slope_errs(jj) = min_slope_err;
        Qs(jj) = Q_crt;
        end
    
        [min_slope_err min_idx] = min(abs(min_slope_errs));
        best_theta = best_thetas(min_idx);        
        best_Q = Qs(min_idx);
       
        change1 = abs(best_theta-spec_theta)*100/spec_theta;
        change2 = abs(best_Q-Q)*100/Q;
        
        fprintf('\nMinimum slope error = %.6furad for: \n  * new theta = %.9f (changes by %.3f percent)\n  * new Q = %.9f (changes by %.3f percent)\n', min_slope_err*10^6, best_theta, change1, best_Q, change2)
    
    
    
    
    
    end




