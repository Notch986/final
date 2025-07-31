clear; clf; hold off

m = 10000;
veces = 50;
ax = -2; bx = 2;
ay = -3; by = 3;
sa = 0;
saa = 0;

for k = 1:veces
    n = 0;
    for i = 1:m
        r = rand;
        x = ax + (bx - ax) * r;
        r = rand;
        y = ay + (by - ay) * r;

        if (x^2 / 4 + y^2 / 9) < 1
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
title('Áreas por el método Monte Carlo')
xlabel('x'); ylabel('y');
axis([-3, 3, -4, 4])
text(0.5, 3.5, promedio)
text(1.5, 3.5, '+-')
text(2, 3.5, desviacion)
