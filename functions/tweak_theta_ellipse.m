function [best_theta, min_slope_err] = tweak_theta_ellipse(active_x,active_phi, params)

% active_x
% active_phi
% params = [P Q theta semn]

P = params(1);
Q = params(2);
spec_theta = params(3);
semn = params(4);

step_theta = spec_theta;

for ii = 1:3
    
    step_theta = step_theta/100;
    %             figure(999), set(gcf,'color','w',  'Position', [300,100, 600, 700]);
    for kk = 1:101
        theta = spec_theta + (kk-51)*step_theta;
        thetas(kk) = theta;
        %         RoC_ellipse = (2*P*Q)/((P+Q)*sin(theta));
        
        slope_ideal = semn*( ((P+Q)*sin(theta)) / ((P+Q)^2-((P-Q)^2)*(sin(theta)^2)) )...
            *( (P-Q)*cos(theta) - sqrt(P*Q)*(((P-Q)*cos(theta)-2*semn*active_x)...
            ./(sqrt(P*Q+((P-Q)*cos(theta))*(semn*active_x)-active_x.^2))));
        
        phi_norm = active_phi-mean(active_phi);
        slope_err = (phi_norm - slope_ideal);  % micro radians
        slope_err = slope_err - mean(slope_err);   
        slope_errs_rms(kk) = get_rms(slope_err);
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
spec_theta = params(3);
change = abs(best_theta-spec_theta)*100/spec_theta;
fprintf('\nMinimum slope error = %.6furad for:\n  * new theta = %.9f (changes by: %.3f percent)\n', min_slope_err*10^6, best_theta, change)

end