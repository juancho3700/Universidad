function ajuste = calibrar_sonometro(sensibilidad, fs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Se acopla el pist�fono al micro del son�metro. El pist�fono genera un
%tono de 1 kHz y 1 Pa de presi�n ac�stica y el micro capta dicha sinusoide
%con un nivel de amplitud que depende de la sensibilidad del
%micro.

n_total = 5*fs; % 5 segundos
sin_1kHz = ????
x = sin_1kHz;

% Para este tono el son�metro debe indicar un nivel de presi�n sonora de 
% 94 dB.

dB=SPL(x, fs, 'S', 0);  %Es necesario completar previamente esta funci�n
dB=dB(end);

ajuste = ????-dB;  % Completar con nivel de presi�n sonora que deber�a indicar
                   % para este tono.