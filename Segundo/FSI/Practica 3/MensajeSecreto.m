function ImOut = MensajeSecreto(im0,mensaje)
%
% Ojo: no funciona si la imagen no es formato uint8
im00 = im2uint8(im0); % Pasar a uint8
msgbin = uint8(mensaje); % Pasar el mensaje a binario (ascii)
msgbin = [msgbin 255]; % 255 = caracter fin de mensaje
%
% Introducir el mensaje en la imagen usando los bits de menor peso
%
cont = 1; % Pixel actual de la imagen
for i=1:length(msgbin)
    aux = msgbin(i); % Valor a introducir
    for j=0:7,
        bit = (bitand(aux,2^j)>0); % Bit j-esimo
        if (bit)
            % Encender el bit de menor peso (si no lo estaba ya)
            im00(cont) = bitor(im00(cont),1);
        else
            % Apagar el bit de menor peso (si no lo estaba ya)
            im00(cont) = bitand(im00(cont),254);
        end
        cont = cont+1; % Pasar al siguiente
    end
end
%
% Dar salida y acabar.
%
ImOut = im00;
            