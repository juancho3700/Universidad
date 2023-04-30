% DSB_LC.m: large carrier AM demodulated with "envelope detection"
time=0.4; Ts=1/10000;                           % sampling interval and time
t=Ts:Ts:time;                                   % define a "time" vector 
fc=1000; c=cos(2*pi*fc*t);                      % define carrier at freq fc
m=.7*sin(2*pi*20*t)+.3*cos(2*pi*70*t);          % create "message" > -1
x = 0.6*c.*m + c;                               % modulate with large carrier
fbe=[0 .05 .1 1]; damps=[1 1 0 0]; L=50;       % low pass filter design 
h=firpm(L,fbe,damps);                           % impulse response of LPF
envv=pi*filter(h,1,max(0,x));                 % find envelope

% generate the figure
figure(1)
subplot(4,1,1), plot(t,m)
ylabel('amplitude'); title('(a) message signal');
axis([0,0.1, -1.5,1.5])
subplot(4,1,2), plot(t,c,'k')
ylabel('amplitude'); title('(b) carrier');
axis([0,0.1, -1.5,1.5])
subplot(4,1,3), plot(t,x,'c')
ylabel('amplitude'); title('(c) modulated signal');
axis([0,0.1, -2,2])
subplot(4,1,4), plot(t,envv,'r')
ylabel('amplitude'); title('(d) output of envelope detector');
axis([0,0.1, 0,2])
xlabel('seconds');

% this shows things a bit more clearly (but won't print well)
figure(2)
plot(t,x,'c')
 hold on
 plot(t,m)
 plot(t,envv,'r')
 ylabel('amplitude')
 xlabel('seconds')
 title('cyan=modulated signal, blue=message, red=envelope')
hold off

% Si usas un rectificador de media onda aparecen componentes en la
% frecuencia de la portadora además de aparecer en el doble de la
% frecuencia de la misma y en la componente continua (f = 0), así que hay
% que ser más exigente con la caracterización de la banda de corte del
% filtro