prompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,~] = xlsread(str);
q=1;
for i = 1:(size(data_sheet)-1)
    if(data_sheet(i,5)~=data_sheet(i+1,5))
        figure('units','normalized','outerposition',[0 0 1 1]);
        
% scatter plot - Pedal angle vs velocity
        plotting_matrix = [data_sheet(q:i,14),data_sheet(q:i,15)];
        matrix = [3000,2];
        a=1;
        for j = q:i 
            if (plotting_matrix(j,2)>0 && plotting_matrix(j,2)<125 && plotting_matrix(j,1)>0) % (0-125kmph) filter
                matrix(a,[1,2]) =  plotting_matrix(j,[1,2]);
                a = a+1;
            end
        end
         
        subplot(2,2,1);
        scatter(matrix(:,1),matrix(:,2));
        xlabel('Pedal Angle(%)')
        ylabel('Velocity(kmph)')
        grid('on');

%% scatter plot - Pedal angle vs Traction Current
        plotting_matrix = [data_sheet(q:i,14),data_sheet(q:i,10)]; % Pedal angle & tracion current
        matrix = [3000,2];
        a=1;
        for j = q:i 
            if (plotting_matrix(j,1)>0)
                matrix(a,[1,2]) =  plotting_matrix(j,[1,2]);
                a = a+1;
            end
        end
              
        subplot(2,2,2);
        scatter(matrix(:,1),matrix(:,2), 25,'g','filled');
        xlabel('Pedal Angle(%)')
        ylabel('Traction Current(A)')
        grid('on');
        
%% 3D line plot for coordinates
        x = data_sheet(q:i,20);
        y = data_sheet(q:i,21);
        z = data_sheet(q:i,22);
        subplot(2,2,3:4);
        plot3(x,y,z,'r');
        xlabel('Longtitude');
        ylabel('Latitude');
        zlabel('Altitude');
        grid( 'on' );
        box( 'on' );
        rotate3d( 'on' );
        colormap( 'Jet' );
        
        q = i+1;
        break;
     end
end