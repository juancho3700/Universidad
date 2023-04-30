function mensaje = LeerMensaje(im0)
%
% Ojo: no funciona si la imagen no es formato uint8
im00 = im2uint8(im0); % Pasar a uint8
msgbin = []; % Mensaje inicialmente en blanco
%
% Ir leyendo el mensaje
%
cont = 1; % Pixel actual de la imagen
aux = -1; % Caracter anterior
while (aux~=255)
    if (aux~=-1)
        % Anhadir el caracter anterior al mensaje (si procede)
        msgbin = [msgbin aux];
    end
    aux = 0;
    for j=0:7,
        bit = (bitand(im00(cont),1)>0); % Bit de menor peso de este pixel
        if (bit)
            % Encender el bit j-esimo
            aux = bitor(aux,2^j);
        end
        cont = cont+1; % Pasar al siguiente pixel
    end
end
%
% Pasar a texto y acabar.
%
mensaje = char(msgbin);
            