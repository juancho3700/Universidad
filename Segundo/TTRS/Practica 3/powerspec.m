% plotspec(x,Ts) plots the spectrum of the signal x% Ts = time (in seconds) between adjacent samples in xfunction powerspec(x,Ts)N = length(x);                                    % length of the signal xt = Ts*(0:N-1);                                   % define a time vector ssf = (-N/2:N/2-1)/(Ts*N);                        % frequency vectorfx  = fft(x);                                % do DFT/FFTfxs = fftshift(fx);                               % shift it for plottingM1=abs(fxs).^2/N/N;M2=10*log10(M1+eps);subplot(2,1,1), plot(ssf,M1)                % plot power spectrumxlim([ssf(1) ssf(end)]);title('Power Spectral Density')xlabel('frequency (Hz)'); ylabel('Power Unit/ Hz'), grid on     % label the axessubplot(2,1,2), plot(ssf,M2)                % plot power spectrum (dB)title('Power Spectral Density')axis([ssf(1) ssf(end) max(M2)-80 max(M2)+5]);xlabel('frequency (Hz)'); ylabel('dB/Hz'), grid on     % label the axes