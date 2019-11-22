
close all


dx = x(2,1)-x(1,1);
for kk = 1:size(phi,2)
    sag_height = intnom(active_phi_roll(:,kk),dx,1);
end

figure,plot3(active_x*10^3, active_height*10^6, sag_height*10^6),grid on

xlabel('x [mm]')
ylabel('tangential [um]')
zlabel('saggital [um]')

figure,plot3(active_x*10^3, active_phi*10^6, active_phi_roll*10^6),grid on

xlabel('x [mm]')
ylabel('tangential slope [urad]')
zlabel('saggital slope [urad]')