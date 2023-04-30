function ajuste = calibrar_sonometro(sensibilidad, fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se acopla el pist�fono al micro del son�metro. El pist�fono genera un
%tono de 1 kHz y 1 Pa de presi�n ac�stica y el micro capta dicha sinusoide
%con un nivel de amplitud que depende de la sensibilidad del
%micro.

n_total = 5*fs; % 5 segundos
sin_1kHz = sensibilidad*sqrt(2)/1000*cos(2*pi*1000/fs*(1:n_total));
x = sin_1kHz;

% Para este tono el son�metro debe indicar un nivel de presi�n sonora de 
% 94 dB.

dB=SPL(x, fs, 'S', 0);
dB=dB(end);

ajuste = 94-dB;