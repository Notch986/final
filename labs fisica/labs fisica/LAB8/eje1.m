clear; clf; hold off

m = 10000;
veces = 50;

%ay = -5; by = 5;
%ax = -3; bx = 3;

ay=-sqrt(24) ;by=sqrt(24);
ax=-2;bx=2;

sa = 0;
saa = 0;

for k = 1:veces
    n = 0;
    for i = 1:m
        r = rand;
        x = ax + (bx - ax) * r;
        r = rand;
        y = ay + (by - ay) * r;

        x1 = (16 - y^2) / 8;
        x2 = (y^2 - 48) / 24;

        if (x >= x2 && x <= x1)
            n = n + 1;
            px(n) = x;
            py(n) = y;
        end
    end

    area = n * (by - ay) * (bx - ax) / m;
    sa = sa + area;
    saa = saa + area^2;
end

prom = sa / veces;
desv = sqrt(veces * saa - sa^2) / veces;
promedio = num2str(prom);
desviacion = num2str(desv);

plot(px, py, '.')
title('Área entre parábolas usando el método Monte Carlo')
xlabel('x'); ylabel('y');
axis([-3, 3, -5, 5])
text(0.5, 4.5, promedio)
text(1.5, 4.5, '+-')
text(2, 4.5, desviacion)
