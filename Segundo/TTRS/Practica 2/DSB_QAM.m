% DSB_SC.m: suppressed carrier with (possible) freq and phase offsetstime=0.2; Ts=1/10000;                           % sampling interval and timet=Ts:Ts:time;                                   % define a "time" vector fc=1000; c=cos(2*pi*fc*t); s=sin(2*pi*fc*t);  m1 = sign (sin(2*pi*30*t)) + sign (cos(2*pi*70*t));m2 = sign (sin(2*pi*70*t)) + sign (cos(2*pi*50*t));noise = 0.08*randn(size(t));x = c.*m1 - s.*m2 + noise;fd = 0; phi = 0;b1 = x.*cos (2*pi*(fc+fd)*t+phi);b2 = -x.*sin (2*pi*(fc+fd)*t+phi);fbe=[0 0.05 0.25 1]; damps=[1 1 0 0]; L=20;h=firpm(L,fbe,damps);mest1=2*filter(h,1,b1);mest2=2*filter(h,1,b2);% generate the figurefigure(1);subplot(4,1,1), plot(t,m1)ylabel('amplitude'); title('message signal');axis([0,0.1,-1.5 1.5])subplot(4,1,2), plot(t,x,'c')ylabel('amplitude'); title('modulated signal');axis([0,0.1, -1.5,1.5])subplot(4,1,3), plot(t,b1,'m')ylabel('amplitude'); title('demodulated signal');axis([0,0.1, -1.5,1.5])subplot(4,1,4), plot(t,mest1,'r')ylabel('amplitude'); title('recovered message');axis([0,0.1, -1.5, 1.5])xlabel('seconds');figure (2);subplot (4,1,1), plot(t,m2)ylabel ('amplitude'); title ('message signal');axis ([0,0.1,-1.5,1.5]);subplot(4,1,2), plot(t,x,'c')ylabel('amplitude'); title('modulated signal');axis([0,0.1, -1.5,1.5])subplot(4,1,3), plot(t,b2,'m')ylabel('amplitude'); title('demodulated signal');axis([0,0.1, -1.5,1.5])subplot(4,1,4), plot(t,mest2,'r')ylabel('amplitude'); title('recovered message');axis([0,0.1, -1.5, 1.5])xlabel('seconds');