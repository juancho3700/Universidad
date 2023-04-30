f = 20; ts = 1/(1010); t = 0:ts:2;

w = sign (cos (2*pi*f*t));
plotspec (w, ts);

% El espectro es un tren de deltas (como el conseguido)

% No, la sinc tiene un ancho de banda infinito