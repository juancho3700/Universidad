function Mascara = ChromaKey(imagen)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
% Mascara.                                         %
%                                                  %
% Busca el color llave en la imagen y hace una     %
% mascara de lo que no es color llave.             %
%                                                  %
% imagen: imagen de entrada.                       %
%                                                  %
% Mascara: los unos indican que puntos no son      %
%          fondo.                                  % 
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
img = im2double(imagen);
[m,n,ndim] = size(img);
umbral = 0.15; % Inicializar
Rmed = 0.1899;
Gmed = 0.6785;
Bmed = 0.4647; % Color llave
%
% Buscar el color llave
%
for i=1:m,
    for j=1:n,
        R = img(i,j,1);
        G = img(i,j,2);
        B = img(i,j,3); % Color de la imagen
        dist1 = (1/3)*(abs(R-Rmed)+abs(G-Gmed)+abs(B-Bmed)); % Distancia (norma 1)
        if (dist1<umbral)
            masc(i,j) = 0.0;
        else
            masc(i,j) = 1.0;
        end
    end
end
ee = strel('square',3);
masc = imclose(imopen(masc,ee),ee); % Corregir la mascara
%
% Final.
%
Mascara = masc;
