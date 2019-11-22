function info = create_info(varargin)
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% creates info about the data analysed by NEO 


if numel(varargin)==0

    info = {};
    info(1,1) = {'Scan files: '};
    info(1,2) = {evalin('base','namelist''')};
    kk = size(info,1)
    info(kk+1,:)= {'Optic name: ',  (evalin('base','optic_name'))};
    kk = size(info,1);
    info(kk+1,:) = {'Instrument: ', (evalin('base','instrument'))};
    kk = size(info,1);
    info(kk+1,:) = {'VFM:  ', (evalin('base','VFM'))};
    kk = size(info,1);
    info(kk+1,:) = {'Measured length [mm]: ', (evalin('base','L')*10^3)};
    kk = size(info,1);
    info(kk+1,:) = {'Analysis length [mm]: ', (evalin('base','active_L')*10^3)};
    kk = size(info,1);
    info(kk+1,:) = {'Fit to: ', (evalin('base','fit_to'))};
    kk = size(info,1);
    
    
if strcmp(evalin('base','fit_to'),'ellipse')
    
    ellipse_params = evalin('base','ellipse_params');
    info(kk+1,:)= {'P [m], Q [m], theta [mrad]  ',  [ellipse_params(1),  ellipse_params(2),  ellipse_params(3)*10^3]};
else
    info(kk+1,:)= {'RoC [m]: ', (evalin('base','roc'))};
end
kk = size(info,1);
info(kk+1,:) = {'Slope error [urad]:', num2str(evalin('base','slope_err_rms')*10^6) };
kk = size(info,1);
info(kk+1,:)= {'Figure error [nm]: ', num2str(evalin('base','height_err_rms')*10^9)};
kk = size(info,1);

else
    s = [varargin{1} '.'];    
    
    info = {};
    info = {'Scan files: ', evalin('base',[s 'namelist'''])};
    kk = size(info,1);
    info(kk+1,:)= {'Optic_name: ', num2str(evalin('base',[s 'optic_name']))};
    kk = size(info,1);
    info(kk+1,:)= {'Instrument: ', num2str(evalin('base',[s 'instrument']))};
    kk = size(info,1);
    info(kk+1,:)= {'Optical surface facing:  ', num2str(evalin('base',[s 'VFM']))};
    kk = size(info,1);
    info(kk+1,:)= {'Measured length: ', num2str(evalin('base',[s 'L'])*10^3) };
    kk = size(info,1);
    info(kk+1,:)= {'Analysis length: ', num2str(evalin('base',[s 'active_L'])*10^3) };
    kk = size(info,1);
    info(kk+1,:)= {'Fit to: ', num2str(evalin('base',[s 'fit_to']))};
    kk = size(info,1);
    if strcmp(evalin('base',[s 'fit_to']),'ellipse')

        ellipse_params = evalin('base',[s 'ellipse_params']);
        info{kk+1,1}= {'Ellipse parameters:  P = ' num2str(ellipse_params(1)) 'm; Q = ' num2str(ellipse_params(2))...
                       'm; theta = ' num2str(ellipse_params(3)*10^3) 'mrad'};
    else
        info{kk+1,1}= {'RoC: ' num2str(evalin('base',[s 'roc'])) ' m'};
    end
    kk = size(info,1);
    info{kk+1,1} = {'Slope error: ' num2str(evalin('base',[s 'slope_err_rms'])*10^6) 'urad'};
    kk = size(info,1);
    info{kk+1,1}= {'Figure error: ' num2str(evalin('base',[s 'height_err_rms'])*10^9) 'nm'};
    kk = size(info,1);


end