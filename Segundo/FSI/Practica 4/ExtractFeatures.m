% FUNCION DE LOS HISTOGRAMAS

% Primero definimos N y calculamos 3 histogramas, uno para cada componente
% RGB

% Nomalizamos los histogramas

% Creamos 3 vectores con la ultima cuarta parte de cada histograma y los
% unimos en la matriz feat



function feat = ExtractFeatures (imagen, N)

    histR = imhist (imagen (:,:,1), N);
    histG = imhist (imagen (:,:,2), N);
    histB = imhist (imagen (:,:,3), N);
    
    histR = histR ./ norm (histR);
    histG = histG ./ norm (histG);
    histB = histB ./ norm (histB);
    
    featR = histR (0.75 * N : N);
    featG = histG (0.75 * N : N);
    featB = histB (0.75 * N : N);

    feat = [featR featG featB];
end

