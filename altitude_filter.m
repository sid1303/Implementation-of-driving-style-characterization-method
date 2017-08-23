function output_array = altitude_filter(array)

for i = 2:(size(array)-1)
    if((array(i)== 0) || (array(i)>600))
        array(i) = mean([array(i-1) array(i+1)]);
    end
end

output_array = array;