% Sonometro.m 
%
% SONOMETRO CON/SIN PONDERACION A.
% Con banco de filtros de octava y de 1/3 de octava.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETROS SONOMETRO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs=  48000;  % frecuencia de muestreo

sensibilidad_micro= 50; % unidades mV/Pa (valor eficaz);

flag_tercios_octava=0; %si es distinto de cero, filtros en tercio de octava

load FiltrosOctavas.mat; %Lee los filtros Hd y Hd3 (octava y tercio de octava)

if (flag_tercios_octava)
    Filtros=Hd3;
else 
    Filtros=Hd;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elegir modo fast o slow 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
modo = 'F';  % modo S (Slow)  o  F (Fast)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Elegir o no ponderación A 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag_A = 0; % 0: sin ponderación A /// 1: con ponderación A


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALIBRACION del sonometro
ajuste = calibrar_sonometro(sensibilidad_micro, fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SEÑAL DE ENTRADA
% Elegir un tipo y comentar (%) las demás
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   
% 1. Sinusoide 
   duracion= 5; %unidades segundos
   n_total=round(duracion*fs);
   f1 = 1000 ;   % unidades Hz
   A =  0.0707; 
   
   x = A*cos(2*pi*f1/fs*(0:n_total-1));
 
% 2. Señal en fichero wav
%    La nueva fs es la leída del fichero.

   %[x fs]=audioread('traffic_short');
   %n_total=length(x);
   %x=reshape(x,1,length(x));

   
   
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Llamada a la funcion SPL (Sound Pressure Level) y Resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if flag_A
        load coef_ponderacionA;
        x_A = filter(b_pondA,a_pondA,x);
        [Lp LeqT Lp_fs prms_fs]= SPL(x_A,fs,modo,ajuste);
    else
        [Lp LeqT Lp_fs prms_fs]= SPL(x,fs,modo,ajuste);
    end


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 % Análisis por bandas
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
  if flag_A 
        x_i=x_A;
  else
        x_i=x;
  end;
  
  [Y nbandas] = Filtrado_Octavas(x_i, Filtros);
  Lp_bandas=[];
  LeqT_bandas=[];
  Lp_fs_bandas=[];
  prms_fs_bandas=[];
  
  for i=1:nbandas
      [Lp_bandas(i,:) LeqT_bandas(i) ...
       Lp_fs_bandas(i,:)  prms_fs_bandas(i,:)]= SPL(Y(i,:),fs,modo,ajuste);
          
  end
  
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mostramos gráficas y resultados por pantalla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Lp
LeqT
Lp_bandas
LeqT_bandas

close all;

figure(1);

t=1/fs:1/fs:length(prms_fs)/fs;
subplot(211),plot(t,prms_fs); grid; title('Presión sonora eficaz');
xlabel('t (s)');
ylabel('p_{rms} (Pa)');

t=1/fs:1/fs:length(Lp_fs)/fs;
subplot(212), plot(t,Lp_fs); grid; title('Nivel de presión sonora');
xlabel('t (s)');
ylabel('L_p (dB)');

figure(2);
ss=size(Lp_fs_bandas);
%La banda cero y la nbandas+1 son ficticias.
temp=[zeros(1,ss(2)); Lp_fs_bandas; zeros(1,ss(2))]; 
mesh(t,0:nbandas+1,temp); axis tight; shading interp;
colorbar;
title('Nivel de presión sonora (dB)');
view(0,90);
xlabel('t(s)');
ylabel('Índice de banda');

figure(3)
hbar=bar(LeqT_bandas);
hbase = get(hbar,'BaseLine');
Leqmin= min(LeqT_bandas);
if (Leqmin<0)
    set(hbase,'BaseValue', min(LeqT_bandas)-10);
end
title('Nivel de sonido continuo equivalente');
xlabel('Índice de banda');
ylabel('L_{eq} (dB)');




 


