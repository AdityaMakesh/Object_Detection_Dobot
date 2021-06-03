obj=videoinput('winvideo',1);
obj.ReturnedColorspace = 'rgb';
B=getsnapshot(obj);

framesAcquired = 0;
while (framesAcquired <= 100) 
    
      data = getsnapshot(obj); 
      framesAcquired = framesAcquired + 1;    
      
      diff_imr = imsubtract(data(:,:,1), rgb2gray(data)); 
      diff_imr = medfilt2(diff_imr, [3 3]);             
      diff_imr = imbinarize(diff_imr,0.18);
      statsr = regionprops(diff_imr, 'BoundingBox', 'Centroid');
      
      diff_img = imsubtract(data(:,:,2), rgb2gray(data)); 
      diff_img = medfilt2(diff_img, [3 3]);             
      diff_img = imbinarize(diff_img,0.18);
      statsg = regionprops(diff_img, 'BoundingBox', 'Centroid'); 
   
  
      % Remove all those pixels less than 300px
      diff_imr = bwareaopen(diff_imr,300);
      diff_img = bwareaopen(diff_img,300);
    
    % Label all the connected components in the image.
     bw = bwlabel(diff_imr, 8);
     bw = bwlabel(diff_img, 8);
    
    % Here we do the image blob analysis.
    % We get a set of properties for each labeled region.
    statsr = regionprops(logical(bw), 'BoundingBox', 'Centroid');
    statsg = regionprops(logical(bw), 'BoundingBox', 'Centroid');
    
    % Display the image
    imshow(data)
    
    hold on
    
    %This is a loop to bound the red objects in a rectangular box.
    for object = 1:length(statsr)
        bbr = statsr(object).BoundingBox;
        bcr = statsr(object).Centroid;
        rectangle('Position',bbr,'EdgeColor','r','LineWidth',2)
        plot(bcr(1),bcr(2), '-m+')
        a=text(bcr(1)+15,bcr(2), strcat('X: ', num2str(round(bcr(1))), '    Y: ', num2str(round(bcr(2))), '    Color: Red'));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'red');
        
        for object1 = 1:length(statsg)
        bbg = statsg(object1).BoundingBox;
        bcg = statsg(object1).Centroid;
        rectangle('Position',bbr,'EdgeColor','r','LineWidth',2)
        plot(bcg(1),bcg(2), '-m+')
        a=text(bcg(1)+15,bcg(2), strcat('X: ', num2str(round(bcg(1))), '    Y: ', num2str(round(bcg(2))), '    Color: Green'));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'red');
        end
    end  
 
  
    hold off
    
end

clear