% Sonometro.m 
%
% SONOMETRO CON/SIN PONDERACION A.
% Sin banco de filtros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETROS SONOMETRO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=  48000;  % frecuencia de muestreo

sensibilidad_micro= 50; % unidades mV/Pa

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elegir modo fast o slow 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modo = 'F';  % modo S (Slow)  o  F (Fast)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elegir o no ponderaci�n A 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag_A = 0; % 0: sin ponderaci�n A /// 1: con ponderaci�n A


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALIBRACION del sonometro
ajuste = calibrar_sonometro(sensibilidad_micro, fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SE�AL DE ENTRADA
% Elegir un tipo y comentar (%) las dem�s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
% 1. Sinusoide 
%    duracion= 5; %unidades segundos
%    n_total=round(duracion*fs);
%    f1 = 1000 ;   % unidades Hz
%    A =  0.0707; 
%    x = A*cos(2*pi*f1/fs*(0:n_total-1));

% 2. Se�al en fichero wav
%    La nueva fs es la le�da del fichero.

   [x fs]=audioread('fsi_g3_v4_B3.wav');
   n_total=length(x);
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Llamada a la funcion SPL (Sound Pressure Level) y Resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if flag_A
        load coef_ponderacionA
        x_A = filter(b_pondA,a_pondA,x);
        [L_p L_T L_p_fs prms_fs]= SPL(x_A,fs,modo,ajuste);
    else
        [L_p L_T L_p_fs prms_fs]= SPL(x,fs,modo,ajuste);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mostramos gr�ficas y resultados por pantalla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

L_p
L_T

close all;
t=1/fs:1/fs:length(prms_fs)/fs;
subplot(211),plot(t,prms_fs); grid; title('Presi�n sonora eficaz');
xlabel('t (s)');
ylabel('p_{rms} (Pa)');

t=1/fs:1/fs:length(L_p_fs)/fs;
subplot(212), plot(t,L_p_fs); grid; title('Nivel de presi�n sonora');
xlabel('t (s)');
ylabel('L_p (dB)');


