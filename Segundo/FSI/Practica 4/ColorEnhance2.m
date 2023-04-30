% FUNCION DEL PREPROCESAMIENTO

% Primero tenemos que coger la imagen que queramos (insertar el nombre en
% la llamada a la funcion) esto va a darte la imagen en uint8

% Pasar la imagen a double

% Poner la imagen en escala de grises

% Sacar el max y min de luminancia

% ImOUT = (ImIN - min) / (max - min)

% Si algun valor es mayor que uno llevarlo a uno y si es negativo llevarlo
% a 0


function imOUT = ColorEnhance2 (imIN) % ImIN es el nombre, no la imagen

    imagen = imread (imIN);
    imagenDouble = im2double (imagen);
    
    imagenGrises = EscalaGrises (imagenDouble);
    
    maxLum = max (max (imagenGrises));
    minLum = min (min (imagenGrises));
    
    imOUT = (imagenDouble - minLum) / (maxLum - minLum);

    ImOUT (imOUT > 1) = 1;
    ImOUT (imOUT < 0) = 0;
    
    figure;
    imshow (imOUT);
    
end