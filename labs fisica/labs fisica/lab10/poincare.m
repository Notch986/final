clear, clf, hold off
n=0; m=20;
% Constantes del Sistema
c=0.24; b=1; d=1; f=0.68; w=1.7;
% Condiciones Iniciales
t=0; x=1; v=-1; tfin = 2000;
% Inicio de la Simulacion
pt(1)=t; pv(1)=v; px(1)=x; h=2*pi/(w*m);
while t<tfin
  n=n+1;
  for i=1:m
    a = feval('duffing',t,x,v,c,b,d,f,w);
    k1 = h*a;
    a = feval('duffing',t+0.5*h,x+h*0.5*v,v+0.5*k1,c,b,d,f,w);
    k2= h*a;
    a=feval('duffing',t+0.5*h,x+0.5*h*(v+0.5*k1),v+0.5*k2,c,b,d,f,w);
    k3= h*a;
    a = feval('duffing',t+h,x+h*v+h*k2*0.5,v+k3,c,b,d,f,w);
    k4= h*a;
    x=x+h*v+h*(k1+k2+k3)/6;
    v=v+(k1+2*k2+2*k3+k4)/6;
    t=t+h;
    if x>+pi
      x=x-2*pi;
    end
    if x<-pi
       x=x+2*pi;
    end
  end
  px(n+1)=x; pv(n+1)=v;
end
plot(px,pv,'.'); grid on; xlabel('x (m)'); ylabel('v (m/s)');

