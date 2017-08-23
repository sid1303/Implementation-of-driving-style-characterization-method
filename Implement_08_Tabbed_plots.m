clear
close all;
prompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,data_sheet_raw] = xlsread(str);

% Calculate and print energy consumed per unit distance
Implement_05_EnergyConsumption; 

q=1;
f = figure('units','normalized','outerposition',[0 0 1 1]);

f.NumberTitle = 'off';  
User_ID = strcat('Plots for Driver ID :', num2str(data_sheet(2,4)) );
f.Name = User_ID;
tabgp = uitabgroup(f);

% Filter for velocity(0-125)
velocity_array = fixoutlier(data_sheet(:,15));
x = 1;

% Filter for altitude for eliminating 0
altitude_array = altitude_filter(data_sheet(:,22));

for i = 1:(size(data_sheet)-1)
    if(data_sheet(i,5)~=data_sheet(i+1,5))
        
        x_axis = datetime(data_sheet_raw((q+1):(i+1),2),...
        'InputFormat','dd-MM-yyyy HH:mm:ss'); % data_sheet_raw since in data_sheet time stamp dosent come in required format
        y_axis = velocity_array(q:i,1);
               
        thistab = uitab(tabgp);
        Reservation_ID = strcat('Res.ID:', num2str(data_sheet(i,5)));
        thistab.Title = Reservation_ID;
        axes('parent',thistab);
        
% Vel vs time graph - 3,2,1        
        s(1) = subplot('Position',[0.045, 0.75, 0.45, 0.2]);
        plot(x_axis,y_axis,'r');
        grid 'on';
        title('Velocity vs time curve')
        xlabel('time');
        ylabel('Velocity(kmph)');

% Vel histogram graph - 3,2,2
        subplot('Position',[0.55, 0.75, 0.43, 0.2]) ;
        histogram_vector = y_axis(y_axis>0 & y_axis<125);
        histogram(histogram_vector);
        title('Velocity histogram');
        xlabel('Velocity(kmph)');
        %s2 = subplot(3,2,2);

% Pedal angle vs Time - 3,2,3
        s(2) = subplot('Position',[0.045, 0.43, 0.45, 0.2]) ;
        plot(x_axis,data_sheet(q:i,14)); %  Pedal angle
        ax = gca;
        ax.YLim = [0 25];
        grid 'on';
        title('Pedal angle vs Time');
        xlabel('Time'); 
        ylabel('Pedal angle(%)');

% Altitude vs Time - 3,2,5
        s(3)= subplot('Position',[0.045, 0.1, 0.45, 0.2]) ;
        plot(x_axis,altitude_array(q:i,1),'k-.');
        ax = gca;
        ax.YLim = [250 650];
        title('Altitude vs Time');
        xlabel('Time');
        ylabel('Altitude(m)');
        grid 'on';
        
% Linking three axes
        linkaxes(s,'x')        
        
% Accelerometer graph -3,2,4
        subplot('Position',[0.58, 0.25, 0.38, 0.36 ])
        scatter(data_sheet(q:i,6),data_sheet(q:i,7),[],'b');
        
        title('Accelerometer Scatter plot');
        xlabel('adxl-x');
        ylabel('adxl-y');
        grid 'on';
              
        
% Text on every ride        
        energyPerUnitDist = strcat('Energy per unit distance: ', num2str(energy_per_unit_dist(x,1)),' Wh/km');        
        subplot('Position',[0.55, 0.1, 0.45, 0.05],'Visible','off');
        text(0.9, 0.1, energyPerUnitDist, 'horizontalAlignment', 'right','verticalAlignment','bottom','FontSize',13)
        
         x = x+1;
         q = i+1;
    end
end

f2 = figure('units','normalized','outerposition',[0 0 1 1]);

% tabs for 2nd figure
tabgp2 = uitabgroup(f2);
q = 1;

% Roll Pitch Calculation
[Roll,Pitch] = Roll_Pitch(data_sheet(:,6),data_sheet(:,7),data_sheet(:,8));
for i = 1:(size(data_sheet)-1)
    if(data_sheet(i,5)~=data_sheet(i+1,5))
        
        x_axis = datetime(data_sheet_raw((q+1):i+1,2),...
        'InputFormat','dd-MM-yyyy HH:mm:ss'); % data_sheet_raw since in data_sheet time stamp dosent come in required format
        
        thistab = uitab(tabgp2);
        Reservation_ID = strcat('Res.ID:', num2str(data_sheet(i,5)));
        thistab.Title = Reservation_ID;
        axes('parent',thistab);
        
        R(1)= subplot(2,1,1);
        plot(x_axis,Roll(q:i,1),'b');
        title('Roll vs Time');
        xlabel('Time');
        ylabel('Roll(deg)');
        grid 'on';
        
        R(2)= subplot(2,1,2);
        plot(x_axis,Pitch(q:i,1),'b');
        title('Pitch vs Time');
        xlabel('Time');
        ylabel('Pitch(deg)');
        grid 'on';
        
        linkaxes(R,'x');
        
        q = i+1;
    end
end