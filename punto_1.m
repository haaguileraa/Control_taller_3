clear
clc
wgr=15; 
PMD=45;
G= zpk([],[-1 -10], [2])
%sistema de fase minima
% 1 Adelanto

[Gg, Ga] = bode(G,wgr)
%fase de C1 para cumplir PMD
C1_a = PMD-180-Ga %esta en grados y 'sin(X)' recibe argumento X en radianes
C1_arad=C1_a*pi/180;
alpha = (1+sin(C1_arad))/(1-sin(C1_arad));
T1= (wgr*sqrt(alpha))^-1;

C1 = tf ([alpha*T1 1],[T1 1])

[C1g, C1a] = bode(C1,wgr);

k = 1/(C1g*Gg);

C = k*C1;

L = C*G;

figure(1)
margin(k*G) 
%title('Bode L1=k*G(S)')
grid on
%hold all
figure(2)
margin(L)
%title('Bode L=k*C1(S)*G(S)')
grid on

T=feedback(L,1)

figure(3)
bode(T)
title('Bode T')
grid on

figure(4)
step(T)
title('Step T')
grid on


e=1/(1+C*G)
figure(5)
step(e)
title('error')
grid on
