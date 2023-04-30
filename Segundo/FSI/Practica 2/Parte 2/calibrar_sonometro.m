function ajuste = calibrar_sonometro(sensibilidad, fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se acopla el pistófono al micro del sonómetro. El pistófono genera un
%tono de 1 kHz y 1 Pa de presión acústica y el micro capta dicha sinusoide
%con un nivel de amplitud que depende de la sensibilidad del
%micro.

n_total = 5*fs; % 5 segundos
sin_1kHz = sensibilidad*sqrt(2)/1000*cos(2*pi*1000/fs*(1:n_total));
x = sin_1kHz;

% Para este tono el sonómetro debe indicar un nivel de presión sonora de 
% 94 dB.

dB=SPL(x, fs, 'S', 0);
dB=dB(end);

ajuste = 94-dB;