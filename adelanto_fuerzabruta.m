% diseño del controlador de adelanto 
PMD =35;
G = zpk([],[-1 -2 -3],2);
k = 100
L1 = k*G;




% inicializacion con el bode inicial del sistema
[GM0, PM0, wg180, wg0] = margin (L1);
% lineas de correccion de la fase que da octave, no es necesario en matlab
if abs(PM0) > 180
    PM0 = PM0-360
end


phi = (PMD-PM0)*pi/180
alfa = (1+sin(phi))/(1-sin(phi));
[GM, PM1, wg180, wg] = margin (sqrt(alfa)*L1);
T1 = 1/(wg*sqrt(alfa));
C = tf([alfa*T1 1],[T1 1]);



% algoritmo de fuerza bruta como el que esta en los libros

for i =1:500
   alfa = alfa+0.002; 
   T1 = 1/(wg*sqrt(alfa));
   C = tf([alfa*T1 1],[T1 1]);
   [GM1, PM1, wg180, wg] = margin (C*L1); 
   teta = PMD-PM1;
   if teta < 0;
      break
   end
end



