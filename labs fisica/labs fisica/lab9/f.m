clear; clf; hold off;

sigma = 10;
r = 28;
b = 8/3;
h = 0.01;
tfin = 15;

y1 = 1;
z1 = 1;
y2 = 1;
z2 = 1;

%Solo x
x1 = 1.000111;
x2 = 1.000011;

t = 0; n = 1;
pt(n) = t;

xt(n) = x1;
yt(n) = y1;
zt(n) = z1;

xt2(n) = x2;
yt2(n) = y2;
zt2(n) = z2;

for t = h:h:tfin
    n = n + 1;

    % Euler 1
    dx1 = sigma*(y1 - x1);
    dy1 = x1*(r - z1) - y1;
    dz1 = x1*y1 - b*z1;

    x1 = x1 + h*dx1;
    y1 = y1 + h*dy1;
    z1 = z1 + h*dz1;

    % Euler 2
    dx2 = sigma*(y2 - x2);
    dy2 = x2*(r - z2) - y2;
    dz2 = x2*y2 - b*z2;

    x2 = x2 + h*dx2;
    y2 = y2 + h*dy2;
    z2 = z2 + h*dz2;

    pt(n) = t;

    xt(n) = x1;
    yt(n) = y1;
    zt(n) = z1;

    xt2(n) = x2;
    yt2(n) = y2;
    zt2(n) = z2;
end

plot(pt, xt, 'b'); hold on;
plot(pt, xt2, 'g');
grid on;
xlabel('Tiempo');
ylabel('Velocidad fluido (x)');
