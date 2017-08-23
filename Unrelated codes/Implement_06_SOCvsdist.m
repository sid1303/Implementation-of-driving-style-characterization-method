%  for all the trips by the user

clear
close all;
prompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,~] = xlsread(str);
%j = 0;

% for i = 2:size(data_sheet)
%     if(data_sheet(i,5)~=data_sheet(i-1,5))
%         j = j+1;
%     end
% end
% 
% if (mod(j,2)==0)
%      x = j/2;
% else
%      x= (j+1)/2;
% end
% 
% subplot_variable = 0;
q = 1;
%f = figure('units','normalized','outerposition',[0 0 1 1]);

for i = 1:(size(data_sheet)-1)    
    if(data_sheet(i,5)~=data_sheet(i+1,5))
         %subplot_variable = subplot_variable+1;
         
         for k = q:i
            if(data_sheet(k,17)~=0)
                S = S + data_sheet(k,17);
                Y = Y + data_sheet(k,9);
            end
        end
        
        %S = nonzeros(data_sheet(q:i,17)); 
        
%         x_axis = S; % distance
%         y_axis = data_sheet(q:i,9);  % SOC
%         
% Plotting graph        
       % subplot(x,2,subplot_variable)
        figure('units','normalized','outerposition',[0 0 1 1]);
        plot(S,Y)
        grid on
        
        q= i+1;
    end
end