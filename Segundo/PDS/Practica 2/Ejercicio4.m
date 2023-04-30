% a)
fc1 = 1477;
fs = 8192;
L = 100;

n = 0 : (L - 1);

h1 = (2/L) * cos ((2 * pi * fc1 * n) / fs);
w = -pi : 1 / 1000 : pi;

H1 = freqz (h1, 1, w);

% b)
fc2 = 852;
h2 = (2/L) * cos ((2 * pi * fc2 * n) / fs);
H2 = freqz (h2, 1, w);

figure (1)
subplot (211), plot (w, abs (H1))
subplot (212), plot (w, abs (H2))

% c)
% El c es hacer la funcion del archivo firpasobanda.m
% Hace un filtro FIR paso banda si le pasas la fs, la fc, la L y la x
% en ese orden

% d)
fs = 8192;
fc = 852;
L = 100;
n = 0 : (L - 1);
x = 5 * cos ((2 * pi * 852 .* n) / fs);

y = firpasobanda (fs, fc, L, x);

figure (2);
plot (abs (y));




