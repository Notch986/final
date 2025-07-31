clear, clf, hold off; n=0; h=0.1;
% Constantes del Sistema
k=1; m=2;
% Condiciones Iniciales
t=0; x=1; v=0; tfin = 30;
% Inicio de la Simulacion
pt(1)=t; pv(1)=v; px(1)=x;
for t=0:h:tfin
n=n+1;

a = feval(’armonico’,x,k,m);
v = v + h*a;
x = x + h*v;
pt(n+1)=t;
px(n+1)=x;
pv(n+1)=v;
pa(n+1)=a;
end
subplot(2,2,1), plot(pt,pa); grid on;
xlabel(’tiempo (s)’);
ylabel(’Aceleracion (m/s2)’)
subplot(2,2,2), plot(pt,pv); grid on;
xlabel(’tiempo (s)’);
ylabel(’Velocidad (m/s)’)
subplot(2,2,3), plot(pt,px); grid on;
xlabel(’tiempo (s)’);
ylabel(’Desplazamiento (m)’)
subplot(2,2,4), plot(px,pv); grid on;
xlabel(’Desplazamiento (m)’);
ylabel(’Velocidad (m/s)’)

