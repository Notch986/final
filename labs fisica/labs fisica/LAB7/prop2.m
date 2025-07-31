clear, clf, hold off; n=0; h=1;
% Condiciones Iniciales
t=0; x=0; v=1.0; tfin = 20; t=0;
% Inicio de la Simulacion
for t=0:(2*pi):tfin
    n=0;
    px=[]; py=[]; pz=[];
    for ix=0:0.01:pi
        x = ix+v*t;
        n = n + 1;
        y = (x-v*t);  % Escala para que vaya de 0 a 2
        px(n)=x;
        py(n)=y;
    end
    for ix=px(n):-0.01:(px(n)/2)-(2*pi)
        x = ix;
        n = n + 1;
        y = 0;  % Línea horizontal en y=0
        px(n)=x;
        py(n)=y;
    end
     plot(px,py); grid on; xlabel('x'); ylabel('y'); hold on
     pause(0.2)
end
