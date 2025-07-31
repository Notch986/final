clear; clf; hold off;
n = 0; m = 200;

% Constantes del sistema
c = 0.24;
b = 1;
d = 1;
f = 0.68;
w = 1.7;

% Condiciones iniciales
t = 0;
x = 1;
v = -1;
tfin = 5000;

h = 2 * pi / (w * m);
T = 2 * pi / w;

px = [];
pv = [];

while t < tfin
    for i = 1:m
        a = duffing_forzado(t, x, v, c, b, d, f, w);
        k1 = h * a;

        a = duffing_forzado(t + 0.5 * h, x + 0.5 * h * v, v + 0.5 * k1, c, b, d, f, w);
        k2 = h * a;

        a = duffing_forzado(t + 0.5 * h, x + 0.5 * h * (v + 0.5 * k1), v + 0.5 * k2, c, b, d, f, w);
        k3 = h * a;

        a = duffing_forzado(t + h, x + h * v + 0.5 * h * k2, v + k3, c, b, d, f, w);
        k4 = h * a;

        x = x + h * v + h * (k1 + k2 + k3) / 6;
        v = v + (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        t = t + h;
    end


    if abs(mod(t, T)) < h
        n = n + 1;
        px(n) = x;
        pv(n) = v;
    end
end

plot(px(1:end-1), pv(1:end-1), 'b.', 'MarkerSize', 8);
hold on;
plot(px(end), pv(end), 'b.', 'MarkerSize', 20);
grid on;
xlabel('x (m)');
ylabel('v (m/s)');
title('Sección de Poincaré - Oscilador de Duffing forzado');
axis tight;



