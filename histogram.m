% Accessing image acquisition device.
vid_obj = videoinput('winvideo');

% Converting the input images to grayscale.
vid_obj.ReturnedColorSpace = 'grayscale';
% Retrieve the video resolution.
vidRes = vid_obj.VideoResolution;

% Create a figure and an image object.
f = figure('Visible', 'off');

% flipping resolution
imageRes = fliplr(vidRes);

subplot(1,2,1);

histo_gram = imshow(zeros(imageRes));

% Set the axis of the displayed image to maintain the aspect ratio of frame
axis image;
setappdata(histo_gram,'UpdatePreviewWindowFcn',@histogram_func);
dbtype('histogram_func.m');

% The PREVIEW function starts the camera and display. The image on which to
% display the video feed is also specified.
preview(vid_obj, histo_gram);

% View the histogram for 10 seconds.
pause(60);
% Clearing all variables
clear all;
close all;