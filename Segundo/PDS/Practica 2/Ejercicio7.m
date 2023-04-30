% a)
% El filtro IIR elimina las frecuencias w' pi/2 y -pi/2

% b)
% Ecuacion del FIR H = [1 - e^(j*pi/2) * z^-1]*[1 - e^(-j*pi/2) * z^-1]
% Ecuacion del IIR H = 1 / [1 - 0.9 * e^(j*pi/2) * z^-1]*[1 - 0.9 * e^(-j*pi/2) * z^-1]

% c)
a1 = 1;
b1 = [1 0 1];
a2 = [1 0 0.81];
b2 = 0.95;

fvtool (b1, a1);
fvtool (b2, a2);

% d)
b = [0.95 0 0.95];
a = [1 0 0.81];

fvtool (b, a);

% e)
% En las gráficas en Analyse hay una opcion que es Pole-Zero Plot
% Le das y ya te salen los diagramas de polos y ceros

% f)
% En la gráfica del fvtool es la primera pestaña del selector de diagramas

% g)
n = 0 : 100;
x1 = 3 * cos (pi .* n);
x2 = 5 * cos ((pi .* n) / 2);

x = x1 + x2;
y = filter (b, a, x);

figure (4);
subplot (211), plot (x);
subplot (212), plot (y);

% La y tiene un tiempo en el que el filtro no funciona bien, por eso al
% principio de la gráfica la señal se va atenuando
