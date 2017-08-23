[data_sheet,~,data_sheet_raw] = xlsread('user_20');

x = datetime(data_sheet_raw(1:1350,2),...
        'InputFormat','dd-MM-yyyy HH:mm:ss');
y1 = data_sheet(1:1350,9);
y2 = data_sheet(1:1350,22);
y3 = data_sheet(1:1350,15);
y4 = data_sheet(1:1350,10);

subplot(4,1,1)
plot(x,y1)
%xlabel('time');
ylabel('Energy Level');

subplot(4,1,2)
plot(x,y2)
%xlabel('time');
ylabel('Altitude');

subplot(4,1,3)
plot(x,y3)
%xlabel('time');
ylabel('Velocity');

subplot(4,1,4)
plot(x,y4)
xlabel('time');
ylabel('Traction Current');