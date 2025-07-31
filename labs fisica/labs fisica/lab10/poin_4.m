clear; clf; hold off
n = 0;
m = 20;

c = 0.1;
b = 0;
d = 0;
f = 0;
w = sqrt(1-(c/2)^2);

t = 0;
x = 1;
v = 1;
tfin = 400;
h = 2 * pi / (w * m);

% Almacenamiento
pt(1) = t;
pv(1) = v;
px(1) = x;

while t < tfin
    n = n + 1;
    for i = 1:m

        a = feval('duffing_subamortiguado', t, x, v, c, b, d, f, w);

        k1 = h * a;
        a = feval('duffing_subamortiguado', t + 0.5 * h, x + 0.5 * h * v, v + 0.5 * k1, c, b, d, f, w);
        k2 = h * a;
        a = feval('duffing_subamortiguado', t + 0.5 * h, x + 0.5 * h * (v + 0.5 * k1), v + 0.5 * k2, c, b, d, f, w);
        k3 = h * a;
        a = feval('duffing_subamortiguado', t + h, x + h * v + 0.5 * h * k2, v + k3, c, b, d, f, w);
        k4 = h * a;

        x = x + h * v + h * (k1 + k2 + k3) / 6;
        v = v + (k1 + 2 * k2 + 2 * k3 + k4) / 6;

        t = t + h;
    end

    px(n + 1) = x;
    pv(n + 1) = v;
end

plot(px, pv, '.');
grid on;

