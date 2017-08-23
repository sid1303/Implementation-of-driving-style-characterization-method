% Velocity vs time curve for all the trips by the user

clear
close all;
prompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,data_sheet_raw] = xlsread(str);
j = 0;

for i = 2:size(data_sheet)
    if(data_sheet(i,5)~=data_sheet(i-1,5))
        j = j+1;
    end
end

if (mod(j,2)==0)
     x = j/2;
else
     x= (j+1)/2;
end

subplot_variable = 0;
  q = 1;
f = figure('units','normalized','outerposition',[0 0 1 1]);

for i = 1:(size(data_sheet)-1)    
    if(data_sheet(i,5)~=data_sheet(i+1,5))
        subplot_variable = subplot_variable+1;
        
% x and y axis for graph plot 
        x_axis = datetime(data_sheet_raw((q+1):i+1,2),...
        'InputFormat','dd-MM-yyyy HH:mm:ss'); % data_sheet_raw since in data_sheet time stamp dosent come in required format
        y_axis = data_sheet(q:i,15);
    
% Plotting graph        
        subplot(x,2,subplot_variable)
        plot(x_axis,y_axis)
        grid on
        title('Velocity vs time curve')
      
        q= i+1;
    end
end