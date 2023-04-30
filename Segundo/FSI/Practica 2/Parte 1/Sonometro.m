% Sonometro.m 
%
% SONOMETRO CON/SIN PONDERACION A.
% Sin banco de filtros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETROS SONOMETRO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=  48000;  % frecuencia de muestreo

sensibilidad_micro= 50; % unidades mV/Pa (valor eficaz)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elegir modo fast o slow 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modo = 'F';  % modo S (Slow)  o  F (Fast)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elegir o no ponderaci�n A 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag_A = 0; % 0: sin ponderaci�n A /// 1: con ponderaci�n A


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Desactivar o activar gr�fico de barra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

flag_barmeter=0; % 0 desactivado, otro valor activado


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALIBRACION del sonometro
ajuste = calibrar_sonometro(sensibilidad_micro, fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SE�AL DE ENTRADA
% Elegir un tipo y comentar (%) las dem�s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
% 1. Sinusoide 
   duracion= 5; %unidades segundos
   n_total=round(duracion*fs);
   f1 = 1000 ;   % unidades Hz
   A =  0.0707; 
   x = ?????

% 2. Se�al en fichero wav
%    La nueva fs es la le�da del fichero.

  %[x fs]=audioread('traffic');
  % n_total=length(x);
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Llamada a la funcion SPL (Sound Pressure Level) y Resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if flag_A
        load coef_ponderacionA
        x_A = filter(b_pondA,a_pondA,x);
        [Lp LeqT Lp_fs prms_fs]= SPL(x_A,fs,modo,ajuste);
    else
        [Lp LeqT Lp_fs prms_fs]= SPL(x,fs,modo,ajuste);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mostramos gr�ficas y resultados por pantalla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lp
LeqT

close all;

figure(1);
t=1/fs:1/fs:length(prms_fs)/fs;
subplot(211),plot(t,prms_fs); grid; title('Presi�n sonora eficaz');
xlabel('t (s)');
ylabel('p_{rms} (Pa)');

t=1/fs:1/fs:length(Lp_fs)/fs;
subplot(212), plot(t,Lp_fs); grid; title('Nivel de presi�n sonora');
xlabel('t (s)');
ylabel('L_p (dB)');


if(flag_barmeter)

    figure(2);

    set(0,'units','pixels')  
    Pix_SS = get(0,'screensize')   %Tama�o de la pantalla en pixels
    %Posici�n del gr�fico de barra
    set(gcf,'Position',[Pix_SS(3)-125 Pix_SS(4)-500 50 500]);

    fb=bar(1,Lp_fs(1));
    xlabel('Lp (dB)');
    set(gca,'YLim',[min(Lp)-40,max(Lp)+20]);
    set(gca,'XTick',[]);

    valores_por_segundo=10;
    inc=round(fs/valores_por_segundo);

    
    %La duraci�n real de la siguiente representaci�n no se corresponde
    %con la duraci�n del sonido analizado.
    
    for i=1:inc:length(Lp_fs)
        pause(1/valores_por_segundo);
        set(fb,'YData',Lp_fs(i));
    end
end


