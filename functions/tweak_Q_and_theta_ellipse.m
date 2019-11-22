function [best_theta, best_Q, min_slope_err] = tweak_Q_and_theta_ellipse(active_x,active_phi, ellipse_params)

% active_x
% active_phi
% params = [P Q theta semn]

P = ellipse_params(1);
Q = ellipse_params(2);
spec_theta = ellipse_params(3);
semn = ellipse_params(4);

step_theta = spec_theta;
Qstep = Q/100/5;
Q_crt = Q+(1-51)*Qstep;
for jj = 1:101
    Q_crt = Q+(jj-51)*Qstep;
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
            *( (P-Q_crt)*cos(theta) - sqrt(P*Q_crt)*(((P-Q_crt)*cos(theta)-2*semn*active_x)...
            ./(sqrt(P*Q_crt+((P-Q_crt)*cos(theta))*(semn*active_x)-active_x.^2))));

        phi_norm = active_phi-mean(active_phi);
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

theta_change = abs(best_theta-spec_theta)*100/spec_theta;
Q_change = abs(best_Q-Q)*100/Q;

fprintf('\nMinimum slope error = %.6furad for: \n  * new Q = %.9f (changes by %.3f percent)\n  * new theta = %.9f (changes by %.3f percent)\n', min_slope_err*10^6,  best_Q, Q_change, best_theta, theta_change)
