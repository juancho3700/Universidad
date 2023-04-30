function [h,H] = bancodefiltrosBP(fs,L,fc)
% La función bancodefiltrosBP genera la respuesta al impulso y la respuesta en
% frecuencia de un conjunto de filtros paso-banda, cada uno con una frecuencia
% central igual a cada uno de los valores incluidos en el vector fc que se le 
% pasa como parámetro.
% La frecuencia de muestreo fs y la longitud de los filtros FIR también se le
% pasan como parámetros.
%
% Sintaxis:
% [h,H] = firpasobanda(fs,L,fc);
%
% Parámetros de entrada:
% fs: frecuencia de muestreo.
% L : Número de muestras (longitud) del filtro.
% fc: vector con las frecuencias centrales de los filtros.
%
% Parámetros de salida:
% h: matriz con las respuestas al impulso de los distintos filtros. Una
% fila por cada filtro.
% H: matriz con las respuestas en frecuencia de los filtros presentes en h.
% Una fila por cada filtro.

% Definimos primero el vector de frecuencias digitales, entre -pi y pi, en las 
% que se va a calcular la respuesta en frecuencia
w = -pi:1/1000:pi;
% Se recorren cada una de las frecuencias centrales del vector fc
for i = 1:length(fc)
    % Respuesta al impulso
    h(i,:) = (2/L)*cos(2*pi*fc(i)*(0:L-1)/fs);
    % Respuesta en frecuencia
    H(i,:) = freqz(h(i,:),1,w);
end

% Representación de las respuestas en frecuencia de los filtros:
figure
plot(w,abs(H(1,:)));
if length(fc)>1
    hold on
    for i = 2:length(fc)
        plot(w,abs(H(i,:)));
    end
    hold off
end
