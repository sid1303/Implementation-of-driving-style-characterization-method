function filtered_op = fixoutlier(data_array)

for i = 2:(size(data_array)-1)
    if(data_array(i)>125)
        data_array(i) = mean([data_array(i-1) data_array(i+1)]);
    end
end

filtered_op = data_array;
