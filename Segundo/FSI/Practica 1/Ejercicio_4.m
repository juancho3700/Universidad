[audio2, fs] = audioread ('pr1_ejercicio2.wav');


% Apartado a)

% % sound (audio2, fs);

% Cuanta más amplitud, el cambio de presión en el aire es mayor y por lo
% tanto lo percibimos como que el volumen es más alto


% Apartado b)

% % sIn = audio2 (1 : fs * 0.2);
% % sMed = audio2 (fs * 0.8 : fs);
% % sFin = audio2 ((length (audio2) - fs * 0.2) : length (audio2));
% % 
% % sound (sIn, fs);
% % sound (sMed, fs);
% % sound (sFin, fs);

% El último tramo tiene una frecuencia tan alta que no se escucha



% Apartado c) y d)

figure (1)
ver_espectro (sFin, 'hanning', 2048, fs);

figure (2)
ver_espectro (sIn, 'hanning', 2048, fs);

% Frecuencia sFin = 20 KHz
% Frecuencia sIn = 43 Hz


% Apartado e)

% % ventana = hanning (2048);
% % spectrogram (audio2, ventana, 0, 2048, fs, 'yaxis');
