function varargout = stitch(varargin)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%  STITCH stitches together SPIP maps from miniFIZ and microXAM
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @stitch_OpeningFcn, ...
    'gui_OutputFcn',  @stitch_OutputFcn, ...
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


% :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
% --- Executes just before stitch is made visible.
function stitch_OpeningFcn(hObject, eventdata, handles, varargin)

    axes(handles.axes1);     cla;         axis off
    axes(handles.axes2);     cla;         axis off
    axes(handles.axes3);     cla;         axis off
    % Choose default command line output for stitch
    handles.output = hObject;
    % Update handles structure
    guidata(hObject, handles);


function varargout = stitch_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** MENU items ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


% --------------------------------------------------------------------
function m_to_base_Callback(hObject, eventdata, handles)
    assignin('base','handles',handles);


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** UICONTROL CALLBACKS ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



% *********   load LEFT dataset   *********
function pb_load_left_Callback(hObject, eventdata, handles)
    C = readSPIPasc
    if isempty(C)
        return
    end
    
    handles.mydata.zz1 = C.data*10^9;
    [handles.mydata.xx1 handles.mydata.yy1] = meshgrid(C.x*10^3, C.y*10^3);
    handles.mydata.fullname1 = C.fname;

    axes(handles.axes1)
    imagesc(handles.mydata.zz1),axis equal,axis off


    % Update handles structure
    guidata(hObject, handles);




    
% *********   load RIGHT dataset   *********
function pb_load_right_Callback(hObject, eventdata, handles)
    C = readSPIPasc;
    if isempty(C)
        return
    end
    %     handles.mydata = struct;
    handles.mydata.zz2 = C.data*10^9;
    [handles.mydata.xx2 handles.mydata.yy2] = meshgrid(C.x*10^3, C.y*10^3);
    handles.mydata.fullname3 = C.fname;

    axes(handles.axes2)
    imagesc(handles.mydata.zz2),axis equal,axis off

    % Update handles structure
    guidata(hObject, handles);


% *********   swap LEFT and RIGHT maps   *********
function pb_swap_Callback(hObject, eventdata, handles)
    disp('not yet')


% *********   stitch left and right maps   *********
function pb_stitch_Callback(hObject, eventdata, handles)

    % \data as xx1, yy1, zz1 and xx1, yy2, zz2.
    xx1 = handles.mydata.xx1;
    yy1 = handles.mydata.yy1;
    zz1 = handles.mydata.zz1;

    xx2 = handles.mydata.xx2;
    yy2 = handles.mydata.yy2;
    zz2 = handles.mydata.zz2;


    %% Stitch
    % sizes
    [h1 w1] = size(xx1);
    [h2 w2] = size(xx2);    
    
    h = str2double(get(handles.e_h,'String'));
    w = str2double(get(handles.e_w,'String'));
    edge = str2double(get(handles.e_edge,'String'));
    
    
    y1 = round(h1-h)/2;
    % choose a comparison window on the right side of the first group
    subx1 = xx1(y1+1:y1+h,w1-(w+edge-1):w1-edge);
    suby1 = yy1(y1+1:y1+h,w1-(w+edge-1):w1-edge);
    subz1 = zz1(y1+1:y1+h,w1-(w+edge-1):w1-edge);

    subxyz1 = [subx1(:) suby1(:) subz1(:)];
    y2 = round(h2-h)/2;

    % compare with corresponding sized windows on the left of the second group
    for jj = 1:(h2-h+1)
        for kk = 1:round(w2-w)
            subx2 = xx2(jj:jj+h-1,kk:kk+w-1);
            suby2 = yy2(jj:jj+h-1,kk:kk+w-1);
            subz2 = zz2(jj:jj+h-1,kk:kk+w-1);
            subxyz2 = [subx2(:) suby2(:) subz2(:)];


            % call function
            [R, T] = align_3Ddata(subxyz1, subxyz2);

            % align first matrix (xyz) to the second one (xyz2)
            subxyz = (R*subxyz1') + repmat(T, 1, w*h);
            subxyz = subxyz';

            % Find the error (distance between corresponding points of xyz2 and xyz3)
            err = subxyz - subxyz2;
            err = err.^2;
            err = sum(err(:));
            rmse(jj,kk) = sqrt(err/(w*h));

            % disp(sprintf('RMSE: %f', rmse));
        end
    end

    [rmse_min i_min] = min(rmse(:));
    rmse_min
    [y x] = ind2sub(size(rmse),i_min);

    % redo the alignment
    subx2 = xx2(y:y+h-1,x:x+w-1);
    suby2 = yy2(y:y+h-1,x:x+w-1);
    subz2 = zz2(y:y+h-1,x:x+w-1);
    subxyz2 = [subx2(:) suby2(:) subz2(:)];

    % call function
    [R, T] = align_3Ddata(subxyz1, subxyz2);

    xyz1 = [xx1(:) yy1(:) zz1(:)];

    %rotate the entire xyz1
    xyz11 = (R*xyz1') + repmat(T, 1, w1*h1);
    xyz11 = xyz11';

    xx11 = reshape(xyz11(:,1),[h1 w1]);
    yy11 = reshape(xyz11(:,2),[h1 w1]);
    zz11 = reshape(xyz11(:,3),[h1 w1]);

    big_picture = nan(max(h1,h2)+abs(y-y1)-1,w1-w+w2-x+1);
    big_picture(1:h1,1:w1) = zz11;
    big_picture((y1+1-y)+1:(y1-y)+h2+1,w1+1:end) = zz2(:,x+w:w2);


    axes(handles.axes3)
        imagesc(big_picture)
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold')
    
    figure, set(gcf,'color','w','Position',[100 100 900 700])
        surf(xx11,yy11,zz11, 'LineStyle', 'none', 'FaceColor', 'interp')
        hold on
        surf(xx2,yy2,zz2, 'LineStyle', 'none', 'FaceColor', 'interp')
        hold off
        colormap(jet), camlight right
        xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
        ylabel('Y-axis [mm]','Fontsize',12,'FontWeight','bold') 
        zlabel('Z-axis [nm]','Fontsize',12,'FontWeight','bold') 
    



% *********   send stitched map to left   *********
function pb_2left_Callback(hObject, eventdata, handles)
    

% *********   save stitched map   *********
function pb_save_Callback(hObject, eventdata, handles)
    
 
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%  Potentially useless    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    function e_h_Callback(hObject, eventdata, handles)
        

    function e_w_Callback(hObject, eventdata, handles)
        

    function e_edge_Callback(hObject, eventdata, handles)    
    
    
    
    

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%                  *** useless create functions ***
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


                function e_h_CreateFcn(hObject, eventdata, handles)
                if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                    set(hObject,'BackgroundColor','white');
                end

                function e_w_CreateFcn(hObject, eventdata, handles)
                if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                    set(hObject,'BackgroundColor','white');
                end

                function e_edge_CreateFcn(hObject, eventdata, handles)
                if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                    set(hObject,'BackgroundColor','white');
                end
