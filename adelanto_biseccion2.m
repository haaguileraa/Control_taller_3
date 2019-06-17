% diseño del controlador de adelanto por el metodo de biseccion

PMD =5;

G = zpk([],[-1 -2 -3],2);
k = 100
L1 = k*G;




% inicializacion con el bode inicial del sistema
[GM, PM, wg180, wg] = margin (L1);
% lineas de correccion de la fase que da octave, no es necesario en matlab
if abs(PM) > 180
    PM = PM-360
end


% vamos a iterar los valores de alfa desde el minimo hasta 20
% asi calculamos los puntos extremos del intervalo [ alfa1 y alfa2] 
phi = (PMD-PM)*pi/180
alfa1 = (1+sin(phi))/(1-sin(phi));
alfa2 = 20; % angulo de 65 grados
T1 = 1/(wg*sqrt(alfa1));
C1 = tf([alfa1*T1 1],[T1 1]);
[GM, PM1, wg180, wg1] = margin (C1*L1);
if abs(PM1) > 180
    PM1 = PM1-360
end
f_alfa1 = PMD-PM1;
[GM2, PM2, wg180, wg2] = margin(sqrt(alfa2)*L1);
T2 = 1/(wg2*sqrt(alfa2));
C2 = tf([alfa2*T2 1],[T2 1]);
[GM2, PM2, wg180, wg2] = margin(C2*L1);
if abs(PM2) > 180
    PM2 = PM2-360
end



%inicializacion del algoritmo de biseccion con 20 iteraciones

for i=1:20
   alfac = (alfa1 + alfa2)/2;
   [GM, PMc, wg180, wgc] = margin (sqrt(alfac)*L1);
   Tc = 1/(wgc*sqrt(alfac));
   CF1 = tf([alfac*Tc 1],[Tc 1]);
   [GM, PMc, wg180, wgc] = margin (CF1*L1);
   f_alfac = PMD -PMc;
   if  f_alfac*f_alfa1 < 0
       alfa2 = alfac;        
   else 
       alfa1 = alfac;
   end   
end




% realizamos otra etapa con el controlador restante


L2 = CF1*L1;
PMD = 30;

% inicializacion con el bode inicial del sistema
[GM, PM, wg180, wg] = margin (L2);
% lineas de correccion de la fase que da octave, no es necesario en matlab
if abs(PM) > 180
    PM = PM-360;
end


% vamos a iterar los valores de alfa desde el minimo hasta 20
% asi calculamos los puntos extremos del intervalo [ alfa1 y alfa2] 
phi = (PMD-PM)*pi/180
alfa1 = (1+sin(phi))/(1-sin(phi));
alfa2 = 20; % angulo de 65 grados
T1 = 1/(wg*sqrt(alfa1));
C1 = tf([alfa1*T1 1],[T1 1]);
[GM, PM1, wg180, wg1] = margin (C1*L2);
if abs(PM1) > 180
    PM1 = PM1-360;
end
f_alfa1 = PMD-PM1;
[GM2, PM2, wg180, wg2] = margin(sqrt(alfa2)*L2);
T2 = 1/(wg2*sqrt(alfa2));
C2 = tf([alfa2*T2 1],[T2 1]);
[GM2, PM2, wg180, wg2] = margin(C2*L2);
if abs(PM2) > 180
    PM2 = PM2-360;
end




for i=1:20
   alfac = (alfa1 + alfa2)/2;
   [GM, PMc, wg180, wgc] = margin (sqrt(alfac)*L2);
   Tc = 1/(wgc*sqrt(alfac));
   CF2 = tf([alfac*Tc 1],[Tc 1]);
   [GM, PMc, wg180, wgc] = margin (CF2*L2);
   f_alfac = PMD -PMc;
   if  f_alfac*f_alfa1 < 0
       alfa2 = alfac;        
   else 
       alfa1 = alfac;
   end   
end

margin(CF2*CF1*L1)

