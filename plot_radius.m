function plot_radius(r,l_1,l_2,l_3,l_4,l_5,O)
theta = linspace(0,2*pi);
figure(2)
axis([0 100 0 100]);
hold on;
for i=1:length(O)
    plot(O(i).r*cos(theta)+O(i).coorditaes(1),O(i).r*cos(theta)+O(i).coorditaes(2),'k','LineWidth',2);
end
hold on
plot(l_1(end).coordiates(1),l_1(end).coordinates(2),'ro','LineWidth',1); % Agent 1
xc_1 = r*cos(theta) + l_1(end).coordinates(1); yc_1 = r*sin(theta) + l_1(end).coordinates(2);
plot(xc_1,yc_1,'r--');

plot(l_2(end).coordiates(1),l_2(end).coordinates(2),'bs','LineWidth',1.5); % Agent 2
xc_2 = r*cos(theta) + l_2(end).coordinates(1); yc_2 = r*sin(theta) + l_2(end).coordinates(2);
plot(xc_2,yc_2,'b--');

plot(l_3(end).coordiates(1),l_3(end).coordinates(2),'gd','LineWidth',1); % Agent 3
xc_3 = r*cos(theta) + l_3(end).coordinates(1); yc_3 = r*sin(theta) + l_3(end).coordinates(2);
plot(xc_3,yc_3,'g--');

plot(l_4(end).coordiates(1),l_4(end).coordinates(2),'h','Color',  [1 0.6 0.05],'LineWidth',1); % Agent 4
xc_4 = r*cos(theta) + l_4(end).coordinates(1); yc_4 = r*sin(theta) + l_4(end).coordinates(2);
plot(xc_4,yc_4,'--','Color',[1 0.6 0.05]);

plot(l_5(end).coordiates(1),l_5(end).coordinates(2),'m^','LineWidth',1); % Agent 5
xc_5 = r*cos(theta) + l_5(end).coordinates(1); yc_5 = r*sin(theta) + l_5(end).coordinates(2);
plot(xc_5,yc_5,'m--');
end