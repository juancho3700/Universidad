% FUNCION MATRIZ DE CONFUSION

function ConfusionMatrix = ConfMat (t, clases, tamHist)

    NF = length (clases);
    ConfusionMatrix = zeros (NF, NF);
    
    for i = 1 : NF
        Files = t (i).Files;
        
        for j = 1 : length (Files)
            
            c = Recognizer (Files {j}, clases, tamHist);
            ConfusionMatrix (i, c) = ConfusionMatrix (i, c) + 1;
            
        end
    end

end