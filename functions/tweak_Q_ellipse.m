function [best_Q, min_slope_err] = tweak_Q_ellipse(active_x,active_phi, params)

% active_x
% active_phi
% params = [P Q theta semn]

P = params(1);
spec_Q = params(2);
theta = params(3);
semn = params(4);

% set step based on the value of specified Q
step_Q = spec_Q;

for ii = 1:3
    
    step_Q = step_Q/100;
%                 figure(999), set(gcf,'color','w',  'Position', [300,100, 600, 700]);
    for kk = 1:101
        Q = spec_Q + (kk-51)*step_Q;
        Qs(kk) = Q;
        %         RoC_ellipse = (2*P*Q)/((P+Q)*sin(theta));
        
        slope_ideal = semn*( ((P+Q)*sin(theta)) / ((P+Q)^2-((P-Q)^2)*(sin(theta)^2)) )...
            *( (P-Q)*cos(theta) - sqrt(P*Q)*(((P-Q)*cos(theta)-2*semn*active_x)...
            ./(sqrt(P*Q+((P-Q)*cos(theta))*(semn*active_x)-active_x.^2))));
        
        phi_norm = active_phi-mean(active_phi);
        slope_err = (phi_norm - slope_ideal);  % micro radians
        slope_err = slope_err - mean(slope_err);
        slope_errs_rms(kk) = sqrt(sum((slope_err-mean(slope_err)).^2)/(numel(slope_err)-1));
    end
    
    [min_slope_err min_idx] = min(abs(slope_errs_rms));
    change = abs(Qs(min_idx)-spec_Q)*100/spec_Q;
    
    Q_min = Qs(min_idx);
    
    
    assignin('base',['Qs' num2str(ii)],Qs*1000000);
    assignin('base',['slope_errs_rms' num2str(ii)],slope_errs_rms*1000000);
    
    
%                 figure(999),
%                 subplot(3,1,ii),
%                 plot(Qs*10^6,slope_errs_rms*10^6,'.b')
%                 hold on
%                 plot(Qs(min_idx)*10^6,   min_slope_err*10^6, 'or','LineWidth',2)
%                 hold off
%                 xlim([Qs(1) Qs(end)]*10^6)
%                 ylabel('slope err rms [urad]','Fontsize',12,'FontWeight','bold')
    
    spec_Q = Qs(min_idx);
    Qs = [];
    
end
best_Q = spec_Q;
spec_Q = params(2);
change = abs(best_Q-spec_Q)*100/spec_Q;
fprintf('\nMinimum slope error = %.6furad for:\n  * new Q = %.9f (changes by: %.3f percent)\n', min_slope_err*10^6, best_Q, change)

end