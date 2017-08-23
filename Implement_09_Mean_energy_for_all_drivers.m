mean_per_driv = zeros(5,1);
DriverID = zeros(5,1);

for k = 1:5    
prompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,~] = xlsread(str);

%% Distance traversed per trip
resID_Dist = [data_sheet(:,5) data_sheet(:,17)]; % resID & Distance
miss = find(data_sheet(:,17)==0);
resID_Dist(miss,:) = [];
m = 1;n=1;
distance_traversed = zeros(30,1);
for dist = 1:(size(resID_Dist)-1)
    if(resID_Dist(dist,1)~= resID_Dist(dist+1,1))
        distance_traversed(n,1) = resID_Dist(dist,2)-resID_Dist(m,2);
        %fprintf('Distance traversed : %d Km \n', distance_traversed(n,1));
        n=n+1;
        m = dist+1;        
    end
end

%% Energy consumption per trip        
q = 1;
resID_energyConsumed = zeros(30,2);
p =1;

for i = 1:(size(data_sheet)-1)
    if(data_sheet(i,5)~=data_sheet(i+1,5))
        energy_consumed = 0;
        
        for energy = q:i
            energy_consumed = energy_consumed + (data_sheet(energy,10)*data_sheet(energy,11)*(2/3600));
        end
        
        resID_energyConsumed(p,[1,2]) = [data_sheet(i,5) energy_consumed] ;
        %fprintf('Energy Consumed during trip with reservation ID %d = %2f Wh\n', data_sheet(i,5), energy_consumed);
        p = p+1;
        q = i+1;
    end
end

%% Energy consumed per unit distance
energy_per_unit_dist = zeros(n-1,1);
for i = 1:(n-1)
    energy_per_unit_dist(i,1) = resID_energyConsumed(i,2)/distance_traversed(i,1);
    %fprintf('Energy consumed per unit distance = %f Wh/Km \n',energy_per_unit_dist(i,1));
end

%% Average Velocity of the driver

Average_Vel = data_sheet(:,15);
Mean_Vel = mean(Average_Vel(Average_Vel>0&Average_Vel<125));
%fprintf('Mean Velocity of the driver for all the rides : %f kmph \n', Mean_Vel);

%% Average energy consumed per unit distance
DriverID(k,1) = data_sheet(1,4);
% mean_per_driv(k,1) = [data_sheet(1,4), mean(energy_per_unit_dist(energy_per_unit_dist ~= inf))]
mean_per_driv(k,1) = mean(energy_per_unit_dist(energy_per_unit_dist ~= inf));

%t = table(resID_energyConsumed,distance_traversed,energy_per_unit_dist)
end
T = table(DriverID,mean_per_driv)