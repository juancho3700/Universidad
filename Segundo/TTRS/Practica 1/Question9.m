freq = [0 140 160 240 260 380 400 560 580 1600] / 1600;
amp = [0 0 1 1 0 0 1 1 0 0];

b = firpm (200, freq, amp);
fvtool (b, 'Fs', 3.2e6);

% El retardo es 200/2 = 100 muestras
% 100 muestras / 3.2 MHz = 0.32 ms