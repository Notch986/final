clear; clf; hold off;


sigma = 10; %numero  prandtl
r = 28; %rayleigh
b = 8/3; %geometrico
h = 0.01; %paso
tfin = 30; %tiempo final

x = 1; %movimiento fluido
y = 1; % temperatura horizontal
z = 1; % temperatura vertical
t = 0;
n = 1;

px(n) = x;
py(n) = y;
pz(n) = z;
pt(n) = t;

for t = 0:h:tfin
    n = n + 1;

    dx = sigma*(y - x);
    dy = x*(r - z) - y;
    dz = x*y - b*z;

    x = x + h*dx;
    y = y + h*dy;
    z = z + h*dz;

    pt(n) = t;
    px(n) = x;
    py(n) = y;
    pz(n) = z;
end

subplot(2,3,1), plot(px, py, 'b'); grid on;
xlabel('velocidad fluido (x)');
ylabel('Temperatura horizontal (y)');

subplot(2,3,2), plot(px, pz, 'r'); grid on;
xlabel('velocidad fluido (x)');
ylabel('Temperatura vertical (z)');

subplot(2,3,3), plot(py, pz, 'g'); grid on;
xlabel('Temperatura horizontal (y)');
ylabel('Temperatura vertical (z)');

subplot(2,3,4), plot(pt, px, 'b'); grid on;
xlabel('Tiempo');
ylabel('velocidad fluido (x)');

subplot(2,3,5), plot(pt, py, 'b'); grid on;
xlabel('Tiempo');
ylabel('temp horizontal');

subplot(2,3,6), plot(pt, pz, 'b'); grid on;
xlabel('Tiempo');
ylabel('temp vertical');


