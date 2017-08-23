% Traction current Histogram for all the trips by the user

clear
close all;
prompt = 'Enter the file name to be imported : ';
str = input(prompt,'s');
[data_sheet,~,~] = xlsread(str);

q = 1;

for i = 1:(size(data_sheet)-1)    
    if(data_sheet(i,5)~=data_sheet(i+1,5))
         
        A = data_sheet(q:i,10);
    
% Plotting graph        
       % subplot(x,2,subplot_variable)
        figure('units','normalized','outerposition',[0 0 1 1]);
        histogram(A)
        grid on
        
        q= i+1;
    end
end