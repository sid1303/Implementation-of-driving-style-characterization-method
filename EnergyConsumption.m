%% Distance Traversed

resID_Dist = [data_sheet(:,5) data_sheet(:,17)]; % resID & Distance
miss = find(data_sheet(:,17)==0);
resID_Dist(miss,:) = [];
m = 1;n=1;
distance_traversed = zeros(30,1);
for i = 1:(size(resID_Dist)-1)
    if(resID_Dist(i,1)~= resID_Dist(i+1,1))
        distance_traversed(n,1) = resID_Dist(i,2)-resID_Dist(m,2);
        
        n=n+1; 
        m = i+1;        
    end
end

%% Energy consumption per trip        
n = 1;
resID = zeros(30,1);
energyConsumed = zeros(30,1);
m =1;

for i = 1:(size(data_sheet)-1)
    if(data_sheet(i,5)~=data_sheet(i+1,5))

        const = (2/3600)*ones(size(data_sheet(m:i,10),1),1); % 2 sec in hrs
        energyConsumed(n,1) = sum(prod([data_sheet(m:i,10) data_sheet(m:i,11) const],2)); % E = V*I*(2/3600) Whr
        
        resID(n,1) = data_sheet(i,5);
        
        n = n+1;
        m = i+1;
    end
end

%% Energy consumed per unit distance
energy_per_unit_dist = zeros(30,1);
for i = 1:(n-1)
    if (distance_traversed(i,1))~=0
        energy_per_unit_dist(i,1) = (energyConsumed(i,1)/distance_traversed(i,1));
    end
end

%% Table format
T = table(resID,energyConsumed,distance_traversed,energy_per_unit_dist);
disp(T);

%% Average energy consumed per unit distance
Mean_energy_consumed_per_unit_distance = mean(nonzeros(energy_per_unit_dist));
fprintf('Mean Energy consumed per unit distance of the driver for all the rides : %0.2f Wh/km \n',...
    Mean_energy_consumed_per_unit_distance);

%% Average Velocity of the driver

Average_Vel = data_sheet(:,15);
Mean_Vel = mean(Average_Vel(Average_Vel>0&Average_Vel<125));
fprintf('Mean Velocity of the driver for all the rides : %0.2f kmph \n', Mean_Vel);