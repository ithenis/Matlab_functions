function [fsignal frequencies] = myFourier(Ts, signal)

%% create data
% ++++++++++++++++++++++++++++++++++++

% sampling parameters
Fs = 1/Ts;          % Sampling frequency
N = numel(signal);                  % Number of samples
time = (0:N-1)'*Ts;          % Time vector



% apply Fourier Transform
fsignal = (fft(signal))/N;            % FT of signal
fsignal = 2*abs(fsignal(1:round(N/2)+1));
frequencies = Fs/2*linspace(0,1,round(N/2)+1)';   % frequencies



return
figure, set(gcf,'color','w', 'Position',[100 50 600 300])
plot(frequencies,fsignal*10^6,'Linewidth',2)
xlabel('Frequency [m^-^1]','Fontsize',12,'FontWeight','bold')
ylabel('Fourier transform','Fontsize',12,'FontWeight','bold')