close all; clear;
%
% Codificação de informação multimédia
% Trabalho 3 - Visual Part assignment 1
%

IMAGE_FILE = 'cameraman.tif';
A = imread(IMAGE_FILE);
figure(1); imshow(A); title('original')

N = 5;

%3.2.1
mean = ones(N, N)/(N^2);
A_mean = aplicarFiltro(A, mean);
figure(2); imshow(uint8(A_mean)); title('Mean filter')

%3.2.2
A_median = medfilt2(A, [N N]);
figure(3); imshow(A_median); title('Median filter')

%3.2.3
sobel = [-1 -2 -1; 0 0 0; 1 2 1];
A_sobel = aplicarFiltro(A, sobel);
A_sobel = aplicarFiltro(A_sobel, sobel');
figure(4); imshow(uint8(A_sobel)); title('Sobel filter')

%3.2.4
prewitt = [-1 0 1; -1 0 1; -1 0 1];
A_prewitt = aplicarFiltro(A, prewitt);
A_prewitt = aplicarFiltro(A_prewitt, flip(prewitt'));
figure(5); imshow(uint8(A_prewitt)); title('Prewitt filter')

function resultado = aplicarFiltro(A, filtro)
    if(length(size(A))<3)
        resultado = conv2(A, filtro, 'same');
    else
        resultado = cat(3, conv2(A(:,:,1), filtro, 'same'), ...
        conv2(A(:,:,2), filtro, 'same'), conv2(A(:,:,3), filtro, 'same'));
    end
end