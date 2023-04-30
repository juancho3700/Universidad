function [Y num_filtros_octava]= Filtrado_Octavas(x, Hd)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FILTRADO DE UNA SEÑAL POR UN FILTRO DE OCTAVAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Entrada:
%       x : señal a filtrar
% Salidas:
%       Y: matriz con una fila por señal paso banda.
%       num_filtros_octava: número de bandas a la salida.
%

Y=[];
ss=size(Hd);
num_filtros_octava=ss(2);
ss=size(Hd(1).sosMatrix);
etapas=ss(1);

for ii=1: num_filtros_octava
    gain = Hd(ii).scaleValues(etapas+1);
     
    y=x;
     
    for jj=1:etapas
        
        bjj= Hd(ii).scaleValues(1)*Hd(ii).sosMatrix(jj,1:3);
        ajj = Hd(ii).sosMatrix(jj,4:6);
        y= filter(bjj,ajj,y);
        
    end

    y = y*gain;   %señal filtrada
    
    Y=[Y; y];
    
end % for ii

