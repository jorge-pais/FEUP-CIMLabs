function y = adapt_thresh(x)
    if std2(x) < 5
        y = zeros(size(x,1), size(x,2));
        % using ones will return a white background
        %y = ones(size(x,1), size(x,2));
    else
        y = im2bw(x, graythresh(x));
    end
end