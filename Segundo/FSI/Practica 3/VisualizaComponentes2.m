function img_comp = VisualizaComponentes2(imc)%imc=im3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %
% Funcion que visualiza componentes (R,G,B) %
% en su color original. %
% %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imR = imc;
imG = imc;
imB = imc; % Inicio
imR(:,:,3) = 0; % Parte amarilla
imG(:,:,2) = 0; % Parte magenta
imB(:,:,1) = 0; % Parte cyan
img_comp = [imc imR imG imB]; % Concatenar imagenes
imshow(img_comp); % Display 