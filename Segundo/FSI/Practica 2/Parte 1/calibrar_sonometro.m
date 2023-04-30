function ajuste = calibrar_sonometro(sensibilidad, fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se acopla el pistófono al micro del sonómetro. El pistófono genera un
%tono de 1 kHz y 1 Pa de presión acústica y el micro capta dicha sinusoide
%con un nivel de amplitud que depende de la sensibilidad del
%micro.

n_total = 5*fs; % 5 segundos
sin_1kHz = ????
x = sin_1kHz;

% Para este tono el sonómetro debe indicar un nivel de presión sonora de 
% 94 dB.

dB=SPL(x, fs, 'S', 0);  %Es necesario completar previamente esta función
dB=dB(end);

ajuste = ????-dB;  % Completar con nivel de presión sonora que debería indicar
                   % para este tono.