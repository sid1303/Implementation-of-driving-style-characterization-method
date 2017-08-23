tprompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,~] = xlsread(str);

figure('units','normalized','outerposition',[0 0 1 1]);

i =size(data_sheet);
   
% scatter plot - Pedal angle vs velocity
        plotting_matrix = [data_sheet(:,14),data_sheet(:,15)];
        matrix = [25000,2];
        a=1;
        for j = 1:i 
            if (plotting_matrix(j,2)>0 && plotting_matrix(j,2)<125 && plotting_matrix(j,1)>0) % (0-125kmph) filter
                matrix(a,[1,2]) =  plotting_matrix(j,[1,2]);
                a = a+1;
            end
        end
         
        subplot(2,1,1);
        scatter(matrix(:,1),matrix(:,2));
        xlabel('Pedal Angle(%)')
        ylabel('Velocity(kmph)')
        grid('on');

% scatter plot - Pedal angle vs Traction Current
        plotting_matrix = [data_sheet(:,14),data_sheet(:,10)]; % Pedal angle & tracion current
        a=1;
        for j = 1:i 
            if (plotting_matrix(j,1)>0)
                matrix(a,[1,2]) =  plotting_matrix(j,[1,2]);
                a = a+1;
            end
        end
              
        subplot(2,1,2);
        scatter(matrix(:,1),matrix(:,2), 25,'g','filled');
        xlabel('Pedal Angle(%)')
        ylabel('Traction Current(A)')
        grid('on');