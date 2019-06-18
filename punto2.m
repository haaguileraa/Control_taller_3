ep = 0.1/100;
PMD=45;
kp=(1/ep)-1;

k = kp/5

PMD =45;
G = zpk([],[-1 -10 ],2);



L1 = k*G;

e=1/(1+L1)
figure(5)
step(e)


%xlim([0 100])
title('error')
grid on