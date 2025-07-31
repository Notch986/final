clear; clf; hold off
m = 1000000;
veces = 70;
% Límites para el paraboloide z = x² + y² con planos coordenados y x + y = 1
% La región está limitada por: x ≥ 0, y ≥ 0, x + y ≤ 1
% Para encontrar el máximo de z en esta región:
% En el vértice más alejado (0,1) o (1,0): z = 1
ax = 0; bx = 1;           % x ∈ [0, 1]
ay = 0; by = 1;           % y ∈ [0, 1]  
az = 0; bz = 1;           % z ∈ [0, 1]
sa = 0;
saa = 0;
for k = 1:veces
 n = 0;
for i = 1:m
 r = rand;
 x = ax + (bx - ax) * r;
 r = rand;
 y = ay + (by - ay) * r;
 r = rand;
 z = az + (bz - az) * r;
 % Superficie del paraboloide: z = x² + y²
 z_superficie = x^2 + y^2;
 % Condiciones: x ≥ 0, y ≥ 0, x + y ≤ 1, z ≤ x² + y²
if (x >= 0 && y >= 0 && (x + y) <= 1 && z <= z_superficie)
 n = n + 1;
 px(n) = x;
 py(n) = y;
 pz(n) = z;
end
end
 volumen = (n/m) * (by - ay) * (bx - ax) * (bz - az);
 sa = sa + volumen;
 saa = saa + volumen^2;
end
prom = sa / veces;
desv = sqrt(veces * saa - sa^2) / veces;
promedio = num2str(prom);
desviacion = num2str(desv);

% Gráfico 3D
scatter3(px, py, pz, 1, 'filled')
title('Volumen del paraboloide z = x² + y² usando método Monte Carlo')
xlabel('x'); ylabel('y'); zlabel('z');
axis([0, 1, 0, 1, 0, 1])
text(0.1, 0.8, 0.9, promedio)
text(0.3, 0.8, 0.9, '+-')
text(0.4, 0.8, 0.9, desviacion)