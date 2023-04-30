
close all;

fs=32000;		% Sampling frequency (Hz)
kf= 800; 		% Frequency deviation constant (Hz/V)
fc=3000; 		% Carrier frequency (Hz)
fm= 200; 		% Modulating frequency (Hz);

N=100000; 		% Number of samples

n=0:N-1;
Ts=1/fs;
t=n*Ts; 		% Sampling times


m=sin(2*pi*fm*t); % Modulating signal
%m=sign(m); % Modulating signal SQUARE
xfm=cos(2*pi*fc*t+2*pi*kf*cumsum(m)*Ts); % FM signal

fo = fc + 100;
xbb = xfm .* exp(-1j*2*pi*fo*t);

L = 400;
h = firpm (L, [0 3600 4000 fs/2]/(fs/2), [1 1 0 0]);
xbb = filter (h, 1, xbb);
xbb = xbb (L/2+1:end);

xbb_1 = [0 xbb(1:end-1)];
v = angle (xbb.*conj(xbb_1));
v = v - mean (v);


figure(1);
nn=1:500;
subplot (311), plot (t(nn), xfm(nn));
title ('Señal transmitida');
subplot (312), plot (t(nn), m(nn));
title ('Mensaje');
subplot (313), plot (t(nn), v(nn));
title ('Señal decodificada');
