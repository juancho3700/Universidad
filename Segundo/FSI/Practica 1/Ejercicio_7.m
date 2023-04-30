[audio4, fs] = audioread ('pr1_ejercicio4.wav');

% Apartado a)

% Fs = 16000


% Apartado b)

% La se�al tiene 49878 muestras y dura 3.1174 s


% Apartado c)

% Hay 16 bits por muestra


% Apartado d)

% Se�al mono


% % Parte b % %

muestraABA = audio4 ((fs * 0.498) : (fs * 0.705));
t = 0 : 1 / fs : (length (muestraABA) - 1) / fs;

figure (1)
plot (t, muestraABA)

figure (2)
ver_espectro (muestraABA, 'hanning', 512, fs)

figure (3)
ventana = hamming (2048);
spectrogram (audio4, ventana, 0, 2048, fs, 'yaxis');

% Apartado a)

% T0 = 0.0081 s => f0 = 123.45 hz


% Apartado b)




% Apartado c)

% Hay m�s energ�a en los arm�nicos del 5� al 10� que la que tienen los
% primeros arm�nicos


% Apartado d)

figure (4)
ventana = hamming (256);
muestraNISMO = audio4 ((fs * 2.3) : length (audio4));
spectrogram (muestraNISMO, ventana, 0, 256, fs, 'yaxis');

% Las zonas de energ�a con las frecuencias m�s altas se corresponden con la
% letra 'I'


% Apartado e)

