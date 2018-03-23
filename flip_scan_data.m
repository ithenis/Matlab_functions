
% load('Zeiss-B11_200mm_cylinder')
% load('Zeiss-B12_200mm_cylinder')
% load('Zeiss-B21_200mm_cylinder')
% load('Zeiss-B22_200mm_cylinder')


slope_err = flipud(-slope_err);
active_height = flipud(active_height);
height_err = flipud(height_err);
active_phi_roll = flipud(-active_phi_roll);


co = [0 0.25 1;   0 0.7 0;   1 0 0;   0 0.75 1;   1 0.5 0;   0.75 0 0.75;   0.25 0 0.75;   0.75 0.25 0];
trim = (L - active_L)/2;
x1 = active_x(1,1)-trim;
x2 = active_x(end,1)+trim;


return

%%    PLOT
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
         
    
figure(14), set(gcf,'color','w',  'Position', [200, 200, 800, 400]);  
set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');  
plot(active_x*10^3, 10^6*active_phi_roll,'LineWidth',1.5)    
xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
ylabel('Twist angle [urad]','Fontsize',12,'FontWeight','bold') 
xlim([x1 x2]*10^3)

figure(13), set(gcf,'color','w',  'Position', [150, 150, 800, 400]);    
set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');      
plot(active_x*10^3, 10^6*slope_err,'LineWidth',1.5)  
xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
ylabel('Slope error [urad]','Fontsize',12,'FontWeight','bold') 
xlim([x1 x2]*10^3)  

figure(12), set(gcf,'color','w',  'Position', [100, 100, 800, 400]);         
set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');         
plot(active_x*10^3, 10^9*height_err,'LineWidth',1.5)           
xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
ylabel('Figure error [nm]','Fontsize',12,'FontWeight','bold') 
xlim([x1 x2]*10^3)

figure(11), set(gcf,'color','w',  'Position', [50, 50, 800, 400]);  
set(gca,'ColorOrder',co(1:8,:),'LineStyleOrder',{'-',':','--'}, 'NextPlot', 'replacechildren','Box','on');    
plot(active_x*10^3, 10^6*active_height,'LineWidth',1.5) 
xlabel('X-axis [mm]','Fontsize',12,'FontWeight','bold')
ylabel('Figure [um]','Fontsize',12,'FontWeight','bold') 
xlim([x1   x2]*10^3)   