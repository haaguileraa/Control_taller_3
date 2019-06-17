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

L1 = C*G;

margin(L1)




%%
L1=k*G;


grid on

[Gm, Pm, w180, wg] = margin(L1)

%%

L=k*C*G
T=feedback(T)
bode(L1)
bode(L)
bode(T)



%% 2 Adelanto
%clear
%clc
ep=0.1/100;
%PMD


%% 3 Atraso
clear
clc
ep=0.1/100;
%PMD


