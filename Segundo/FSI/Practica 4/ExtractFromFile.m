% FUNCION CONJUNCION DE PREPROCESAMIENTO E HISTOGRAMAS

function CMatrix = ExtractFromFile (archivo, tamHist)

    imagen = ColorEnhance2 (archivo);
    CMatrix = ExtractFeatures (imagen, tamHist);

end