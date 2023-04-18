% This is script is used to select diferent types of 
% preprocessing

function I = preprocessing(input)

    %I = imgaussfilt(input, 5);

    %figure; imshow(I); title('Pre-processed Image');
    
    %I(:,:,1) = imadjust(input(:,:,1));
    %I(:,:,2) = imadjust(input(:,:,2));
    %I(:,:,3) = imadjust(input(:,:,3));

    I = input; % do nothing
end
