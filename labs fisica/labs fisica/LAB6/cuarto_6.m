clear; clf; hold off;
xa=-2:0.4:2;
ya=-2:0.4:2;
B1=1;
[x,y]=meshgrid(xa,ya);

% Parámetros del hexágono
a = 1.5;  % radio del hexágono

% Vértices del hexágono regular centrado en el origen
x1 = a;           y1 = 0;              % vértice 1 (0°)
x2 = a/2;         y2 = a*sqrt(3)/2;    % vértice 2 (60°)
x3 = -a/2;        y3 = a*sqrt(3)/2;    % vértice 3 (120°)
x4 = -a;          y4 = 0;              % vértice 4 (180°)
x5 = -a/2;        y5 = -a*sqrt(3)/2;   % vértice 5 (240°)
x6 = a/2;         y6 = -a*sqrt(3)/2;   % vértice 6 (300°)

for zi=-2:0.4:2
    B1=B1+50;

    % Campo magnético de cada lado del hexágono (alambre infinito)
    % Lado 1-2
    r12_sq = (x-x1).^2 + (y-y1).^2;
    r12_sq(r12_sq < 0.1) = 0.1;
    Bx12 = -B1*(y-y1)./r12_sq;
    By12 = B1*(x-x1)./r12_sq;

    % Lado 2-3
    r23_sq = (x-x2).^2 + (y-y2).^2;
    r23_sq(r23_sq < 0.1) = 0.1;
    Bx23 = -B1*(y-y2)./r23_sq;
    By23 = B1*(x-x2)./r23_sq;

    % Lado 3-4
    r34_sq = (x-x3).^2 + (y-y3).^2;
    r34_sq(r34_sq < 0.1) = 0.1;
    Bx34 = -B1*(y-y3)./r34_sq;
    By34 = B1*(x-x3)./r34_sq;

    % Lado 4-5
    r45_sq = (x-x4).^2 + (y-y4).^2;
    r45_sq(r45_sq < 0.1) = 0.1;
    Bx45 = -B1*(y-y4)./r45_sq;
    By45 = B1*(x-x4)./r45_sq;

    % Lado 5-6
    r56_sq = (x-x5).^2 + (y-y5).^2;
    r56_sq(r56_sq < 0.1) = 0.1;
    Bx56 = -B1*(y-y5)./r56_sq;
    By56 = B1*(x-x5)./r56_sq;

    % Lado 6-1
    r61_sq = (x-x6).^2 + (y-y6).^2;
    r61_sq(r61_sq < 0.1) = 0.1;
    Bx61 = -B1*(y-y6)./r61_sq;
    By61 = B1*(x-x6)./r61_sq;

    % Campo total en el plano xy
    Bx = Bx12 + Bx23 + Bx34 + Bx45 + Bx56 + Bx61;
    By = By12 + By23 + By34 + By45 + By56 + By61;

    % Coordenada z constante para este nivel
    z = zi*x./x;

    % Campo magnético en z (para alambre infinito, principalmente en xy)
    Bz = 0*sqrt(x.^2+y.^2);

    % Dibujar vectores de campo en 3D
    quiver3(x,y,z,Bx,By,Bz); hold on
end

% Dibujar el hexágono en varios niveles z para mostrar la estructura
for zi=-2:0.8:2
    z_hex = zi*ones(7,1);
    plot3([x1 x2 x3 x4 x5 x6 x1], [y1 y2 y3 y4 y5 y6 y1], z_hex, 'r-', 'LineWidth', 2);
end

axis square;
xlabel('x'); ylabel('y'); zlabel('z');
title('Campo Magnético - Alambre Infinito Hexagonal');
view(3); % vista 3D
grid on;
