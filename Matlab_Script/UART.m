clear;
close all;
delete(instrfindall);


% Read in image and convert to grey scale
Input_IMG = imread('2.png');
subplot(1,3,1), imshow(Input_IMG); title('Original Image');
Input_BW = rgb2gray(Input_IMG);
subplot(1,3,2), imshow(Input_BW);  title('Grey Image');

% Get image size
[row, col] = size(Input_BW);


% Open Serial Port
S = serial('COM4', 'BAUD', 9600);
fclose(S);
fopen(S);


%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.
% Send one image data at a time and read back immediately
% Set the top_direct_send as top_level and program FPGA
% Test this first to determine the functionality of UART on board
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Output_Image = zeros(row, col);
% Send out data row by row
for r = 1 : row
    for c = 1 : col
        fwrite(S, Input_BW(r,c), 'uint8');
        pause(0.000001);                        % Add delay between each sending!!!!!!!!! Important!
        Output_Image(r, c) = fread(S, 1);
    end
end
% Plot the received image
subplot(1,3,3), imshow(uint8(Output_Image));  title('Processed Image');
%}


%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.
% Send a series of data and read back all at once
% Set the top as top_level and program FPGA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for x = 1:500
    fwrite(S, x, 'uint8');
    pause(0.000001);                % Add delay between each sending!!!!!!!!! Important!
end
for y = 1:5
    vec = fread(S, 100);
    XXX(y,:) = vec';
end
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.
% Send all IMAGE data first then read all back
% Set the top as top_level and program FPGA
% Use this segment of code for Lab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Output_Image = zeros(row, col);
% Send out data row by row
for r = 1 : row
    for c = 1 : col
        fwrite(S, Input_BW(r,c), 'uint8');
        pause(0.000001);                % Add delay between each sending!!!!!!!!! Important!
    end
end

% Add delay between send data and receive data so FPGA can have time to
% process the image data. The delay value is depending on your FPGA 
% processing time. If the read operation can't receive data in a certain
% time, the matlab script will timeout and quit.

% pause(60);                % Pause 60 seconds

for y = 1 : row
    vec = fread(S, 100);
    Output_Image(y,:) = vec';
end


% Plot the received image
subplot(1,3,3), imshow(uint8(Output_Image));  title('Processed Image');



% Close Serial Port
fclose(S);