

clear; clf; hold off;

% Inicialización de variables
n = 0;
m = 20;
c = 0; b = 1; d = 1; f = 0; w = 1;

t = 0;
x = 1;
v = 0;
tfin = 1000;

pt(1) = t;
pv(1) = v;
px(1) = x;

h = 2 * pi / (w * m);

while t < tfin
    n = n + 1;
    for i = 1:m
        kx1 = h * v;
        kv1 = h * feval('armonico', t, x, v, c, b, d, f, w);

        kx2 = h * (v + 0.5 * kv1);
        kv2 = h * feval('armonico', t + 0.5 * h, x + 0.5 * kx1, v + 0.5 * kv1, c, b, d, f, w);

        kx3 = h * (v + 0.5 * kv2);
        kv3 = h * feval('armonico', t + 0.5 * h, x + 0.5 * kx2, v + 0.5 * kv2, c, b, d, f, w);

        kx4 = h * (v + kv3);
        kv4 = h * feval('armonico', t + h, x + kx3, v + kv3, c, b, d, f, w);

        % Actualización de estado
        x = x + (kx1 + 2 * kx2 + 2 * kx3 + kx4) / 6;
        v = v + (kv1 + 2 * kv2 + 2 * kv3 + kv4) / 6;
        t = t + h;
    end
    px(n + 1) = x;
    pv(n + 1) = v;
end

% Gráfico de resultados
plot(px, pv, '.');
grid on;
xlabel('x (m)');
ylabel('v (m/s)');
axis([-100 100 -100 100]);
