% FUNCION DE RECONOCIMIENTO

% Primero sacamos el histograma de la imagen a reconocer

% Recorres clases y comparas el histograma de antes con los pattern de
% clases

% Calculas la distancia entre histograma y clases.pattern y con eso sacas
% el resultado

function C = Recognizer (imagen, clases, tamHist)

    patron = ExtractFromFile (imagen, tamHist);
    
    
    for i = 1 : length (clases)
       
        aux = abs (patron - clases (i).pattern);
        distancia (i) = sum (aux (:));
        
    end
    
    [~, C] = min (distancia);
end