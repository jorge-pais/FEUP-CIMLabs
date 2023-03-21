close all; clear;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

IMAGE_FILE = 'cameraman.tif';
A = imread(IMAGE_FILE);
figure(1); imshow(A); title('original')
drawnow
N = 3;

%3.2.1
mean = ones(N, N)/(N^2);
A_mean = aplicarFiltro(A, mean);
figure(2); imshow(uint8(A_mean)); title('Mean filter')
drawnow

%3.2.2
A_median = medianfilter2D(A, N);
figure(3); imshow(A_median); title('Median filter')
drawnow

%3.2.3
sobel = [-1 -2 -1; 0 0 0; 1 2 1];
A_sobel = aplicarFiltro(A, sobel);
A_sobel = aplicarFiltro(A_sobel, sobel');
figure(4); imshow(uint8(A_sobel)); title('Sobel filter')
drawnow

%3.2.4
prewitt = [-1 0 1; -1 0 1; -1 0 1];
A_prewitt = aplicarFiltro(A, prewitt);
A_prewitt = aplicarFiltro(A_prewitt, flip(prewitt'));
figure(5); imshow(uint8(A_prewitt)); title('Prewitt filter')
drawnow

function resultado = aplicarFiltro(A, filtro)
    if(length(size(A))<3)
        resultado = conv2(A, filtro, 'same');
    else
        resultado = cat(3, convolucao2D(A(:,:,1), filtro), ...
            convolucao2D(A(:,:,2), filtro), ...
            convolucao2D(A(:,:,3), filtro));
%         resultado = cat(3, conv2(A(:,:,1), filtro, 'same'), ...
%         conv2(A(:,:,2), filtro, 'same'), conv2(A(:,:,3), filtro, 'same'));
    end
    %resultado = uint8(resultado);
end

function resultado = convolucao2D(input, kernel)
    [height1, width1] = size(input);
    [height2, width2] = size(kernel);

    paddedA = padarray(input, [floor(height2/2) floor(width2/2)]);

    resultado = zeros(height1, width1);
    for i=1:height1
        for j=1:width1
            resultado(i,j)=sum(sum(kernel.*paddedA(i:i+height2-1, j:j+width2-1)));
        end
    end
end

function resultado = medianfilter2D(input, windowSize)
    [height1, width1] = size(input);
    
    paddedA = padarray(input, [floor(windowSize/2), floor(windowSize/2)]);

    resultado = zeros(height1, width1);

    for i = 1:height1
        for j = 1:width1
            window = paddedA(i:i+windowSize-1, j:j+windowSize-1);
            
            resultado(i, j) = median(window(:));
        end
    end
    resultado = uint8(resultado);
end
