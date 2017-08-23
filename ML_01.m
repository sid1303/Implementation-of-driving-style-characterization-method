prompt = 'Enter the number of inputs : ';
No_of_inputs = input(prompt);

Array = zeros(1,8);
mean_per_driv = zeros(5,1);

for loop = 1 : No_of_inputs
   
    prompt = 'Enter the file name to be imported : ';
    str = input(prompt,'s');
    disp('Working on the data ...');
    [data_sheet,~,~] = xlsread(str);
    
% Distance traversed per trip
    resID_Dist = [data_sheet(:,5) data_sheet(:,17)]; % resID & Distance
    miss = find(data_sheet(:,17)==0);
    resID_Dist(miss,:) = [];
    m = 1;n=1;
    distance_traversed = zeros(30,1);
    for dist = 1:(size(resID_Dist)-1)
        if(resID_Dist(dist,1)~= resID_Dist(dist+1,1))
            distance_traversed(n,1) = resID_Dist(dist,2)-resID_Dist(m,2);

            n=n+1;
            m = dist+1;        
        end
    end
    disp('..')
    
% Energy consumption per trip        
    q = 1;
    energyConsumed = zeros(30,2);
    p =1;

    for i = 1:(size(data_sheet)-1)
        if(data_sheet(i,5)~=data_sheet(i+1,5))
            energy_consumed = 0;

            for energy = q:i
                energy_consumed = energy_consumed + (data_sheet(energy,10)*data_sheet(energy,11)*(2/3600));
            end

            energyConsumed(p,[1,2]) = energy_consumed ;
            p = p+1;
            q = i+1;
        end
    end
    disp('..')
    
% Energy consumed per unit distance for each ride
    energy_per_unit_dist = zeros(n-1,1);
    for i = 1:(n-1)
        if (distance_traversed(i,1))~=0
            energy_per_unit_dist(i,1) = energyConsumed(i,2)/distance_traversed(i,1);
        end
    end
    
% mean_per_driv(k,1) = [data_sheet(1,4), mean(energy_per_unit_dist(energy_per_unit_dist ~= inf))]
    mean_per_driv = mean(nonzeros(energy_per_unit_dist));  
    
    pedal_angle = nonzeros(data_sheet(:,14));
    pedal_angle(pedal_angle>25) = [];
    pa_mean = mean(pedal_angle);
    pa_std = std(pedal_angle);

    velocity = nonzeros(data_sheet(:,15));
    velocity(velocity>=125) = [];
    vel_mean = mean(velocity);
    vel_std = std(velocity);
    
    disp('..')
    [Roll, Pitch] = Roll_Pitch(data_sheet(:,6),data_sheet(:,7),data_sheet(:,8));
    Roll = nonzeros(Roll);
    Pitch = nonzeros(Pitch);
    Roll_mean = mean(Roll);
    Roll_std = std(Roll);
    Pitch_mean = mean(Pitch);
    Pitch_std = std(Pitch);
    
    Traction_Current = data_sheet(:,10);
    Filtered_Traction_Current = Traction_Current(((-60)<Traction_Current) & (Traction_Current<250));
    Traction_Current_std = std(Filtered_Traction_Current);
    
    Driver_ID = data_sheet(1,4);

    Array(loop,1:11) = [Driver_ID pa_mean pa_std vel_mean vel_std Roll_mean Roll_std Pitch_mean Pitch_std mean_per_driv Traction_Current_std];

    disp('Done');
end


Data_Table = array2table(Array,'VariableNames',{'Driver_ID','PA_mean','PA_std','Velocity_mean','Velocity_std','Roll_mean',...
    'Roll_std','Pitch_mean','Pitch_std','Mean_Per_Driv','Traction_Current_std'});

Labels = categorical([3 3 2 1 2 3 3 2 1 2]');
Data_Table.Eff_Labels = Labels;

disp(Data_Table);
% training_data = [Array, mean_per_driv];