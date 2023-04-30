% DSB_SC.m: suppressed carrier with (possible) freq and phase offsets
time=0.2; Ts=1/10000;
t=Ts:Ts:time;
fc=2000; fend = 500;

m = .7 * sin (2 * pi * 70 * t) + .3 * cos (2 * pi * 100 * t);
x = m .* cos (2 * pi * fc * t);

figure (1)
plotspec (m, Ts)

figure (2);

s_mid = x .* cos (2 * pi * (fc - fend) * t);
plotspec (s_mid, Ts)
fbe = [0 250 350 650 750 fc/2]/(fc/2);
famp = [0 0 1 1 0 0];

h = firpm (80, fbe, famp);
s_ol = 2 * filter (h, 1, s_mid);

plotspec (s_ol, Ts)