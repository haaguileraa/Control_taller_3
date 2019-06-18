ep = 0.1/100;
PMD=45;
kp=(1/ep)-1;

%1
k = kp*5; %ep < 0.1% 
PMD =45;
G= zpk([],[-1 -10], [2])

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
wpg=10.2;

%si se desea el valor exacto:
wgg=0;
[L1m, L1a] = bode(L1,wgg);
for i=0:0.01:15
    want=0;
    if L1a ~= L1_a
        wgg = want + i;
        [L1m, L1a] = bode(L1,wgg);
    end
    if -L1a + L1_a > 0 %&& L1a <= L1_a*1.1
       [L1m, L1a] = bode(L1,wgg)
       break 
    end
end
 



