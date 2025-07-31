clear; clf; hold off
m = 10000;
veces = 50;
% Límites para y = ln x & y = ln² x
ax = 1; bx = exp(1);        % x ∈ [1, e]
ay = 0; by = 1;             % y ∈ [0, 1]
sa = 0;
saa = 0;
for k = 1:veces
 n = 0;
for i = 1:m
 r = rand;
 x = ax + (bx - ax) * r;
 r = rand;
 y = ay + (by - ay) * r;
 % Funciones: y1 = ln(x), y2 = ln²(x)
 y1 = log(x);              % y = ln x
 y2 = log(x)^2;            % y = ln² x
if (y >= y2 && y <= y1)
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
title('Área entre y = ln x y y = ln² x usando el método Monte Carlo')
xlabel('x'); ylabel('y');
axis([1, exp(1), 0, 1])
text(1.5, 0.8, promedio)
text(2, 0.8, '+-')
text(2.3, 0.8, desviacion)