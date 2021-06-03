close all
clear


vid=videoinput('winvideo',2);
%Set the frames&RGB
set(vid,'FramesPerTrigger',inf);
set(vid,'ReturnedColorspace','rgb')
%Set timer of screenshoting of images per millisecond
vid.FrameGrabInterval=1;
%Acquiring video
start(vid);
%Set number of Frames in video
while(vid.FramesAcquired<=100000)
    %To store extracted frames
    closepreview(vid);
    data = getsnapshot(vid);
    %extracting the Red color from grayscale image
    diff_im=imsubtract(data(:,:,1),rgb2gray(data));
    %Filtering the noise
    diff_im=medfilt2(diff_im,[3,3]);
    %Converting grayscale image into binary image
    diff_im=imbinarize(diff_im,0.18);
    %remove all pixels less than 300 pixel
    diff_im=bwareaopen(diff_im,300);
    %Draw rectangular boxes around the red object detected & label image
    bw=bwlabel(diff_im,8);
    
    stats=regionprops(bw,'BoundingBox','Centroid');
    %Show image
    imshow(data);
    
    hold on 
    %create a loop for the regtangular box
    for object=1:length(stats)
        %saving data of centroid and boundary in BB & BC 
        bb=stats(object).BoundingBox;
        bc=stats(object).Centroid;
        %Draw the rectangle with data BB & BC
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        %Plot the rectangle output
        plot(bc(1),bc(2),'-m+')
        %Output X&Y coordinates
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        
    end
       hold off
       
      
end
release(data);
stop(vid); 