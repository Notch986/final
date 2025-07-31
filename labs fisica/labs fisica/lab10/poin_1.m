clear; clf; hold off;
n = 0;
h = 0.1;

% Condiciones iniciales
t = 0;      % tiempo inicial
x = 1;
v = 1;
tfin = 30;

% Almacenar condiciones iniciales
pt(1) = t;
px(1) = x;
pv(1) = v;
pa(1) = x - x^3;  % aceleración inicial

for t = 0:h:tfin
    n = n + 1;

  a = feval('cubica',x);
    k1 = h*a;
    a = feval('cubica',x+h*0.5*v);
    k2= h*a;
    a=feval('cubica',x+0.5*h*(v+0.5*k1));
    k3= h*a;
    a = feval('cubica',x+h*v+h*k2*0.5);
    k4= h*a;
    x=x+h*v+h*(k1+k2+k3)/6;
    v=v+(k1+2*k2+2*k3+k4)/6;

    pt(n + 1) = t + h;    % tiempo corregido
    px(n + 1) = x;
    pv(n + 1) = v;
    pa(n + 1) = a;        % almacenar aceleración
end

subplot(2, 2, 1);
plot(pt, px); grid on;    %tiempo en x, posición en y
xlabel('Tiempo (s)');
ylabel('Posición x (m)');
title('x - t');

subplot(2, 2, 2);
plot(pt, pv); grid on;    % tiempo en x, velocidad en y
xlabel('Tiempo (s)');
ylabel('Velocidad v (m/s)');
title('v - t');

subplot(2, 2, 3);
plot(px, pv); grid on;
xlabel('Posición x (m)');
ylabel('Velocidad v (m/s)');
title('Espacio de fases: x - v');

