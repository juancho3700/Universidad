% Apartado a)

[audio1, fs1] = audioread ('pr1_ejercicio1.wav');
audioinfo ('pr1_ejercicio1.wav');

% Apartado b)
% Fs = 16000;

% Apartado c)
% n = 48001;

% Apartado d)
% 16 b/muestra

% Apartado e)
% 3.0001 s

% Apartado f)
% Señal mono

% Apartado g)

sound (audio1, fs1);
soundsc (audio1, fs1);

% El sound reproduce y el soundsc autoescala antes


% Apartado h)
% La diferencia es que la 2a se escucha mas agudo