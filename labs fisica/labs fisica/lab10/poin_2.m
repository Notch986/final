clear; clf; hold off;
n = 0;
h = 0.1;

% Parámetro de amortiguamiento
c = 0.1;  % coeficiente de amortiguamiento (puedes modificar este valor)

% Condiciones iniciales
t = 0;      % tiempo inicial
x = 1;
v = 1;
tfin = 30;

% Almacenar condiciones iniciales
pt(1) = t;
px(1) = x;
pv(1) = v;
pa(1) = x - x^3 - c*v;  % aceleración inicial con amortiguamiento

for t = 0:h:tfin
    n = n + 1;

    % RK4 con función cubica2
    a = feval('cubica2',x,v,c);
    k1 = h*a;

    a = feval('cubica2',x+h*0.5*v,v+0.5*k1,c);
    k2= h*a;

    a = feval('cubica2',x+0.5*h*(v+0.5*k1),v+0.5*k2,c);
    k3= h*a;

    a = feval('cubica2',x+h*v+h*k2*0.5,v+k3,c);
    k4= h*a;

    % Actualización RK4
    x = x+h*v+h*(k1+k2+k3)/6;
    v = v+(k1+2*k2+2*k3+k4)/6;

    pt(n + 1) = t + h;    % tiempo corregido
    px(n + 1) = x;
    pv(n + 1) = v;
    pa(n + 1) = a;        % almacenar aceleración
end

subplot(2, 2, 1);
plot(pt, px); grid on;    % tiempo en x, posición en y
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



