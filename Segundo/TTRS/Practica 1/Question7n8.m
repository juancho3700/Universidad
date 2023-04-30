freq = [0 0.24 0.26 0.74 0.76 1];
amp = [0 0 1 1 0 0];
b = firpm (32, freq, amp);

fvtool (b);


% Atenuación mínima = -12 dB

% Valor pico a pico de la banda de paso = 1.94 dB - (-2.5 dB) = 3.44 dB

% Retardo de grupo = derivada de la fase respecto a la frecuencia dividido
% entre 2pi
% Para los filtros con fase lineal el retardo es el orden del filtro entre
% 2 => retardo = 16 muestras

% Si haces los valores de margen de las frecuencias de corte mas pequeños
% el filtro funciona peor

% Si aumentas el número de coeficientes el filtro atenua mucho más la banda
% suprimida y el rizado de la banda que no se suprime es mucho menor