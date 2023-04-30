function img_comp = VisualizaComponentes(imc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% Funcion que visualiza componentes (R,G,B) %
% en su color original. %
% %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imR = imc;
imG = imc;
imB = imc; % Inicio
imR(:,:,[2 3]) = 0; % Parte roja
imG(:,:,[1 3]) = 0; % Parte verde
imB(:,:,[1 2]) = 0; % Parte azul
img_comp = [imc imR imG imB]; % Concatenar imagenes
imshow(img_comp); % Display 