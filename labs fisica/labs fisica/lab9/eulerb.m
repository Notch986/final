clear, clf, hold off; n=0; h=0.01; k=-0.05;
 tfin=30;
for vy=-0.01:k:-3
    vx=0.0; y=0; x=4; n=0;
    px(1)=x; py(1)=y;
    for t=0:h:tfin
        n=n+1;
        x=x+vx*h;
        y=y+vy*h;
        vx=vx+ax(x,y)*h;
        vy=vy+ay(x,y)*h;
        px(n+1)=x;
        py(n+1)=y;
    end
    plot(px,py); hold on
end
hold off
