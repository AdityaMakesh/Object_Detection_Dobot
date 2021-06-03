function histogram_func(obj,point,hist)
% This function callbacks the frame and the histogram.

% Display the current image frame. 
set(hist, 'CData', point.Data);

% Select the second subplot on the figure for the histogram.
subplot(1,2,2);

% Plot the histogram. Choose 128 bins for faster update of the display.
imhist(point.Data, 128);

% Refresh the display.
drawnow;