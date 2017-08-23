% Pedal angle calculation       
    pedal_angle = nonzeros(data_sheet(:,14));
    pedal_angle(pedal_angle>25) = [];
    pa_mean = mean(pedal_angle);
    pa_std = std(pedal_angle);
    

% Velocity calculation    
    velocity = nonzeros(data_sheet(:,15));
    velocity(velocity>=125) = [];
    vel_mean = mean(velocity);
    vel_std = std(velocity);
 
% Roll and pitch calculation    
    disp('..')
    [Roll, Pitch] = Roll_Pitch(data_sheet(:,6),data_sheet(:,7),data_sheet(:,8));
    Roll = nonzeros(Roll);
    Pitch = nonzeros(Pitch);
    Roll_mean = mean(Roll);
    Roll_std = std(Roll);
    Pitch_mean = mean(Pitch);
    Pitch_std = std(Pitch);

% Traction current calculation    
    Traction_Current = data_sheet(:,10);
    Filtered_Traction_Current = Traction_Current(((-60)<Traction_Current) & (Traction_Current<250));
    Traction_Current_std = std(Filtered_Traction_Current);
    
    Driver_ID = data_sheet(1,4);

    classifier_input = [pa_mean pa_std vel_mean vel_std Roll_mean Roll_std Pitch_mean Pitch_std...
        Mean_energy_consumed_per_unit_distance Traction_Current_std];

    disp('Done');
    
    Table = [Driver_ID pa_mean pa_std vel_mean vel_std Roll_mean Roll_std Pitch_mean Pitch_std...
        Mean_energy_consumed_per_unit_distance Traction_Current_std];
    

Data_Table = array2table(Table,'VariableNames',{'Driver_ID','PA_mean','PA_std','Velocity_mean','Velocity_std','Roll_mean',...
    'Roll_std','Pitch_mean','Pitch_std','Mean_Per_Driv','Traction_Current_std'});

disp(Data_Table);

load DriverBehaviourClassifier;

prediction = predict(DriverBehaviour, classifier_input);

disp('Predicted Efficiency : ');
disp(prediction);