clear
close all

%allow to select 4 points in a set of axes (empty) and plot coordinates of
%those 4 points selected
figure(1)
[x,y] = ginput(4);
plot(x,y);

% Create geographic axes and identify the latitude and longitude 
% coordinates of four points. Then, plot the points that you identify.
figure(2)
geoaxes;
[lat,lon] = ginput(4);
hold on
geolimits('manual')
geoscatter(lat,lon,'filled','b')

% Get coordinates of 3 points in an image and plot their intensity values
figure(3)
i=imread('moon.tif');
imshow(i)
[x,y]=ginput(3);
plot(i(x,y));

 % getpts allows to choose points interactively in the displayed image 
 % using the mouse. Double-click to complete your selection.
 % getpts returns the coordinates of your points
figure(4)
imshow(i)
[x,y]=getpts

fprintf('\n Press a key to continue\n'); pause

close all;