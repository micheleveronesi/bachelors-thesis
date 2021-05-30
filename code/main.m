clear;
clc;
dataset = fopen('dataset.txt', 'r');
y_file = fopen('y.txt', 'w');
x_file = fopen('x.txt', 'w');

line = fgetl(dataset);
while ischar(line)
    % converting txt line to array
    splitted = split(line, ';');
    wavelengths = str2double(split(splitted(3), ','));
    reflectance = str2double(split(splitted(2), ','));
    
    % removing dirty channels
    idx = ismember(reflectance, 1.23e34);
    reflectance(idx) = [];
    wavelengths(idx) = [];
    
    % interpolation
    x = linspace(wavelengths(1), wavelengths(end), 2000);
    s = spline(wavelengths, reflectance, x);
    
    % writing result to files
    fprintf(y_file, '%d\n', str2double(splitted(1)));
    fprintf(x_file, '%f ',s);
    fprintf(x_file, '\n');
    
    % getting next line
    line = fgetl(dataset);
end

fclose(dataset);
fclose(y_file);
fclose(x_file);