% FUNCION DE ENTRENAMIENTO

% Primero divides las imagenes en archivos de entrenamiento y de test
% verdes y rojos

% Inicializas las clases de manzanas y les implantas los archivos de
% entrenamiento

% Entrenas al programa y lo testeas

function classes = RecogTrainer (tamHist)
    
    trainG = {'F01.jpg' 'F02.jpg' 'F03.jpg'};
    trainR = {'F07.jpg' 'F08.jpg' 'F09.jpg'};

    classes (1).name = 'green apple';
    classes (1).trainfiles = trainG;

    classes (2).name = 'red apple';
    classes (2).trainfiles = trainR;

    for i = 1 : length (classes)
        
        Files = classes (i).trainfiles;
        aux = ExtractFromFile (Files {1}, tamHist);
        
        for j = 2:length (Files)
            aux = aux + ExtractFromFile (Files {j}, tamHist);
        end
    
        classes(i).pattern = aux / length (Files);
    end
end