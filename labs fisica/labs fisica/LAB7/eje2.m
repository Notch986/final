clear, clf, hold off; n=0; h=1;
% Constantes del Sistema
k=1; m=2; a=10;
% Condiciones Iniciales
t=0; x=0; v=1.0; tfin = 10; t=0;
% Inicio de la Simulacion
for t=0:6.28:tfin
    n=0;
    px=[]; py=[]; pz=[];
    for ix=0:0.01:6.28
        x = ix+v*t;
        n = n + 1;
        y = sin(x-v*t);
        z = sin(x-v*t);
        px(n)=x;
        py(n)=y;
        pz(n)=z;
        pn(n)=0;
    end
     plot3(px,py,pn); grid on; xlabel('x'); ylabel('y'); zlabel('z'); hold on
     plot3(px,pn,pz); grid on; xlabel('x'); ylabel('y'); zlabel('z'); hold on
     pause(0.2)
end
%subplot(2,2,1), plot(pt,pa); grid on;xlabel('tiempo (s)');ylabel('Aceleracion (m/s2)')
%subplot(2,2,2), plot(pt,pv); grid on;xlabel('tiempo (s)');ylabel('Velocidad (m/s)')
%                  plot(xpt,px); grid on;xlabel('tiempo (s)');ylabel('Posicion (m)')
% subplot(2,2,4), plot(px,pv); grid on;xlabel('Posicion (m)');ylabel('Velocidad (m/s)')

