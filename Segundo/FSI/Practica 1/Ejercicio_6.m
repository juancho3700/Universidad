[audio3, fs] = audioread ('pr1_ejercicio3.wav');
% % sound (audio3, fs);


% Apartado a)

% Fs = 16 KHz


% Apartado b)

% La señal tiene 45640 muestras
% Dura 2.8525 s


% Apartado c)

% Hay 16 bits/muestra


% Apartado d)

% Es mono (la matriz de muestras solo tiene una columna)


% Apartado e)

muestraA = audio3 ((fs * 0.395) : (fs * 0.480)); % Saque los tiempos con Audacity
% % sound (muestraA, fs);

t1 = 0 : 1 / fs : (length (muestraA) - 1) / fs;
% % plot (t1, muestraA);

% T0 = 0.0046 s => f0 = 217.4 Hz


% Apartado f)

% % ver_espectro (muestraA, 'hanning', 512, fs);

% En el espectro se ven la frecuencia fundamental y los armónicos


% Apartado g)

% Arm1     F = 218.8 Hz     P = -34.77 dB
% Arm2     F = 437.5 Hz     P = -32.29 dB
% Arm3     F = 656.3 Hz     P = -26.76 dB
% Arm4     F = 875 Hz       P = -27.82 dB
% Arm5     F = 1094 Hz      P = -41.41 dB


% Apartado h)

muestraS = audio3 ((fs * 1.660) : (fs * 1.739)); % Tiempos con Audacity
t2 = 0 : 1 / fs : (length (muestraS) - 1) / fs;
% % sound (muestraS, fs)

% % figure (1)
% % subplot (211)
% % plot (t1, muestraA)
% % subplot (212)
% % plot (t2, muestraS)


% Apartado i)

muestraAudio = audio3 ((1.15 * fs) : (1. * fs));
% % ver_espectro (muestraA, 'hanning', 1024, fs);

% Tiene potencia más uniforme que la a


% Apartado j)

% % ventana = hamming (1024);
% % figure (2)
% % spectrogram (audio3, ventana, 0, 1024, fs, 'yaxis');


% Apartado k)

muestraA2 = audio3 ((fs * 0.295) : (fs * 0.580));

% % subplot (211)
% % ventana = hamming (1024);
% % spectrogram (muestraA2, ventana, 0, 1024, fs, 'yaxis');
% % 
% % subplot (212)
% % spectrogram (muestraA, ventana, 0, 1024, fs, 'yaxis');
% % 
% % figure (1)
% % ver_espectro (muestraA, 'hanning', 1024, fs);
% % figure (3)
% % ver_espectro (muestraA2, 'hanning', 1024, fs);


% Apartado l)

ventana = hamming (64);
spectrogram (audio3, ventana, 0, 64, fs, 'yaxis');


% Apartado m)

figure (1)
spectrogram (audio3, ventana, 0, 128, fs, 'yaxis');
axis ([0 2.85 0.2 0.7]);


% Apartado n)

figure (2)
spectrogram (audio3, ventana, 0, 128, fs, 'yaxis');
axis ([0 2.85 0.7 3]);






