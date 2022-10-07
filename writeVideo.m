% This code produces a video of the cross-diffusion solution computed, and 
% saves it as 'output.mp4'. skip defines how many time steps to skip, and 
% ActualLength is the actual length of the video in seconds.

v = VideoWriter('output.mp4', 'MPEG-4');
skip = 10; ActualLength = 10;
v.FrameRate = length(T(1:skip:end))/ActualLength;

open(v)
close all;
g = figure;
g.Position(3) = 2*g.Position(3);
g.Position(4) = 1.5*g.Position(4);
g.Position(1:2) = 0.5*g.Position(1:2);
plot(x, u(end,:),'linewidth',2);hold on;
plot(x,Uss(x),'--k','linewidth',2)
xlabel('$x$','interpreter','latex')
ylabel('$u$','interpreter','latex')
umax = max(max(u)); umin = min(min(u));
for i = 1:skip:length(T)
    plot(x, u(i,:),'linewidth',2);hold on;
    plot(x,Uss(x),'--k','linewidth',2)
    xlabel('$x$','interpreter','latex')
    ylabel('$u$','interpreter','latex')
    for Xs = xs
        line([Xs,Xs], [umin, umax],'linestyle','--','color','r','linewidth',2);
    end
    axis tight;
    drawnow;
    frame = getframe(gcf);
    writeVideo(v,frame);
    hold off;
    pause(0.001);

end
close(v);