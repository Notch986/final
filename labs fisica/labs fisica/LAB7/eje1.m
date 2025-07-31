clear, clf, hold off; n=0; h=1;
% Condiciones Iniciales
t=0; x=0; v=1.0; tfin = 8; t=0;
% Inicio de la Simulacion
for t=0:2.0:tfin
    n=0;
    px=[]; py=[]; pz=[];
    for ix=-1:0.01:1
        x = ix+v*t;
        n = n + 1;
        y = x-v*t;
        px(n)=x;
        py(n)=y;
    end
     plot(px,py); grid on; xlabel('x'); ylabel('y'); hold on
     pause(0.2)
end



