%
% Demo de "Chroma-Key"....
%
% Pues eso... es una demo de una tecnica muy usada en estudios de TV.
%
Escenario = imread('vigo.bmp'); % Tenemos un escenario "virtual"
ImCamara = imread('FondoVerde1.bmp'); % Y una imagen que viene de la camara
%
% Ahora se "funden las dos".
%
Mascara = ChromaKey(ImCamara); % Se busca el color llave y se "destaca" lo que no es color llave
Resultado = Fusion(Escenario,ImCamara,Mascara,120); % Y se "mezclan" las dos imagenes
figure,imshow(ImCamara),title('Imagen Capturada.');
figure,imshow(Escenario),title('Fondo <<enlatado>>.');
figure,imshow(Resultado),title('Mezcla.'); % Y se enseña todo....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MUCHOS ESTAREIS PENSANDO QUE ESTO SE HACE MEJOR CON EL PHOTOSHOP, ¿NO?
%% ES CIERTO PERO....
%% Y SI LO QUEREIS HACER EN MEDIA HORA DE VIDEO
%% (1800 segundos x 25 imag/seg = 45000 imagenes).
%%
%% ALGUNA SOLUCION HABRIA,
%% ¿RECORTAR AL PRESENTADOR "A MANO" Y PEGARLO EN TODAS LAS IMAGENES? 
%% SOLO SIRVE SI NO SE MUEVE
%%
%% O LO QUE ES MUCHO PEOR: ¿QUE PASA SI LO QUEREMOS HACER EN TIEMPO REAL?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
