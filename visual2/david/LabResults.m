% Alteracoes a fazer:
% - Melhorar a funcao predicate
% - Colocar a diferentes niveis de cizento ou cores os resultados

close all; clear;

IMAGE_FILE = '../../someImages/Fosforos.tif';

I = imread(IMAGE_FILE);
figure, imshow(I), title("Original Image");

% Select 0 -> splitmerge;
%        1 -> clustering (0->cbcr : 1->luminosity : other -> if grayscale)

I=imfilter(I,fspecial("gaussian", 5, 10));


result = lab(I, 0, 2);
figure, imshow(result), title("Segmented Image");

% B = labeloverlay(I,result);
% figure, imshow(B), title("Overlayed Image");

% result = imdilate(result,[1 1 1, 1 1 1, 1 1 1]);
% 
% T = graythresh(result);
% I_thresh2 = im2bw(I,T);
% result = lab(result,0,213103);
% figure, imshow(result), title("2 step Segmented Image");
% 
% n_obj = bwconncomp(I_thresh2,8)
% L = labelmatrix(n_obj);
% figure, imshow(label2rgb(L,'jet','k','shuffle')), title("Labeled Image");

function result=lab(Image, option, channel)
    
    if option == 0
        I = Image;
        if numel(size(Image)) == 3
            I = rgb2gray(Image);
        end
        result = splitmerge(I,4,@predicate);
    elseif option == 1
        L = clustering(Image, 2, channel);
        result = L *100;
    end     

end

function flag=predicate(region)
    sd = std2(region);
    m = mean2(region);
    flag = (sd > 10) & ((m > 80/255) | (m < 40/255));
end

% Criterios (Homogeneidade dos tons de cinza):
% 1 - uniforme, escala de cizento e' constante ou num intervalo;
% 2 - comparacao da me'dia local 'a me'dia global;
% 3 - variancia
