
close all;

[s, fss]=audioread('radio3.wav');
s=reshape(s,1,length(s));
s=s/max(abs(s));
sound(s,fss);
m=interp(s,80);  



fs=fss*80;  	% Sampling frequency (Hz)
kf=25e3; 		% Frequency deviation constant (Hz/V)
fc=100e3; 		% Carrier frequency (Hz)

N=length(m); 	% Number of samples
nfft=N; 		% Number of points of the FFT
df=fs/nfft; 	% Spectral resolution

n=0:N-1;
Ts=1/fs;
t=n*Ts; 		% Sampling times

%FM signal
xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); 


figure(1)
powerspec(xfm,1/fs);


% Question 3

% La regla de Carson dice que para K = 25 KHz => BW = 10 KHz