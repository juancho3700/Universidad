% % % 3.1 % % %

[audio1, fs] = audioread ('pr1_ejercicio1.wav');

% % t = 0 : 1 / fs : (length (audio1) - 1) / fs;
% % figure (1)
% % plot (t, audio1);
% % 
% % figure (2)
% % subplot (211);
% % plot (t, audio1);
% % axis ([0 0.02 -1 1])
% % 
% % subplot (212);
% % plot (t, audio1);
% % axis ([2.98 3 -1 1])

% Apartado a)
% T1 = 0.005s => f1 = 200 Hz
% T2 = 0.002 / 3s => f2 = 1500 Hz


% % % 3.2 % % %

% Apartado a)

% La funcion recoge la señal, normaliza la ventana que va a utilizar.
% "Rellena" el vector de datos hasta tener 1024 muestras en la ventana.
% Hace la convolución entre la señal y la ventana.
% Coge solo las frecs entre 0 - pi (es simetrica asi que si no lo haces
% simplemente va a salir 2 veces en vez de 1)
% Representa


% Apartado b) y c)

% % figure (1)
% % ver_espectro (audio1, 'hamming', 1024, fs)
% % 
% % figure (2)
% % ver_espectro (audio1, 'hanning', 1024, fs)

% La ventana hanning tiene los picos de frecuencia más finoas que la
% hamming, pero también meten más mierda a los lados


% Apartado d)

% % MuestraAudio = audio1 (length (audio1) - (fs * 0.5) : length (audio1));
% % 
% % figure (1)
% % ver_espectro (MuestraAudio, 'rectangular', 64, fs)
% % 
% % figure (2)
% % ver_espectro (MuestraAudio, 'rectangular', 256, fs)
% % 
% % figure (3)
% % ver_espectro (MuestraAudio, 'rectangular', 512, fs)
% % 
% % figure (4)
% % ver_espectro (MuestraAudio, 'rectangular', 1024, fs)
% % 
% % figure (5)
% % ver_espectro (MuestraAudio, 'rectangular', 2048, fs)

% Cuantos más bits utilices en la ventana más precisa será la
% representación espectral de la onda


% Apartado e)

% % MuestraAudio = audio1 (1 : (fs * 0.5));
% % 
% % figure (1)
% % ver_espectro_log (MuestraAudio, 'rectangular', 64, fs)
% % 
% % figure (2)
% % ver_espectro_log (MuestraAudio, 'rectangular', 256, fs)
% % 
% % figure (3)
% % ver_espectro_log (MuestraAudio, 'rectangular', 512, fs)
% % 
% % figure (4)
% % ver_espectro_log (MuestraAudio, 'rectangular', 1024, fs)
% % 
% % figure (5)
% % ver_espectro_log (MuestraAudio, 'rectangular', 2048, fs)

% La ventana de 64 bits tiene tan poca resolución que no es capaz de
% recoger el pico de frecuencia con la escala logarítmica


% Apartado f)

figure (1)
ver_espectro_log (audio1, 'rectangular', 1024, fs)

figure (2)
ver_espectro_log (audio1, 'hanning', 1024, fs)

% La rectangular hace los lóbulos principales mucho más precisos, pero los
% secundarios también son significativamente más grandes

% -12 dBs = 10^-13 Ud. Naturales


% Apartado g)




% % % 3.3 % % %

% %  3.3.1  % %

% % ventana = hamming (2048);
% % spectrogram (audio1, ventana, 0, 2048, fs, 'yaxis');


% Apartado a)

% Se representan las frecuencias de la señal.


% Apartado c)

% Frecuencia = 1.5 KHz


% Apartado d)

% Frecuencia = 200 Hz


% Apartado e)

% Al ser la ventana muy grande, hay una parte en la que se solapan la
% onda de 200 Hz y la de 1500


% %  3.3.2  % %

figure (1)
ventana = hamming (128);
spectrogram (audio1, ventana, 0, 128, fs, 'yaxis');


% Apartado a) y b)

figure (2)
ventana = hamming (256);
spectrogram (audio1, ventana, 0, 256, fs, 'yaxis');

% En la ventana más pequeña el análisis del tono es más preciso pero los
% transitorios entre los dos tonos se superponen
