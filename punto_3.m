clear
clc
ep = 0.1/100;
PMD=45;
kp=(1/ep)-1;
%
k = kp*5; %ep < 0.1% 
PMD =45;
G= zpk([],[-1 -10], [2]);

L1 = k*G;

%% 2
[GM1, PM1, wg180, wg] = margin (L1);
PM1
figure(1)
margin(L1)
grid on
%title('margin L1')

%% 3
L1_a = PMD-180+5.7;
%por metodo grafico, la frecuencia w'g
%wprima_g=10.2;


%si se desea el valor exacto:
wgp=0;
[L1m, L1a] = bode(L1,wgp);
for wgp=0:0.01:15
    if L1a ~= L1_a
        [L1m, L1a] = bode(L1,wgp);
    end
    if -L1a + L1_a > 0 
        %se obtiene A para w'g y se confirma que L1a satisfaga
        % L1a = PMD-180+5.7 acá se obtiene una diferencia de 
        %0.0237 grados debida al tamaño de aumento de i 
       [L1m, L1a] = bode(L1,wgp)
       break 
    end
end
%% 4 
A=20*log10(L1m) 
alpha = 10^-(A/20)

%alternativamente
alpha2 = 1/abs(freqresp(L1,wgp,'rad/s'))
%% 5 obtencion parametro T1 del compensador
T1=10/(alpha*wgp)

C2= tf([alpha*T1 1], [T1 1]) %polo mas cerca del origen

C=k*C2;
L = C*G;

figure(1)
margin(L1) 
%title('Bode L1=k*G(S)')
grid on
%hold all
figure(2)
margin(L)
%title('Bode L=k*C1(S)*G(S)')
grid on
%%
T=feedback(L,1)

figure(3)
bode(T)
title('Bode T')
grid on

figure(4)
step(T)
title('Step T')
grid on

%% error

e=1/(1+C*G)
figure(5)
step(e)
title('error')
grid on


[epf, t] = step(e,5000);

ep_dc=dcgain(e)




%% Pruebas obtención de alpha

z=i*wgp;
ele1 = k*2/((z+1)*(z+10))
alp = 1/abs(ele1)


