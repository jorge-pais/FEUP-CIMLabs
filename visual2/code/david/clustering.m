function y = clustering(I, k, channel)
    % channel = 0 -> cbcr : 1 -> y
    if ((channel == 0) || (channel == 1))
        ycbcr = rgb2ycbcr(I);
        % usando informacao da luminosidade
        lum = ycbcr(:,:,1);
        lum = im2single(lum);
        % Usando informacao da cor
        cbcr = ycbcr(:,:,2:3);
        cbcr = im2single(cbcr);
    end
    % hsv = rgb2hsv(I);
    % h = hsv(:,:,1);
    % h = im2single(h);
    % s = hsv(:,:,2);
    % s = im2single(s);
    % v = hsv(:,:,3);
    % v = im2single(v);

    %I = imfilter(I,fspecial("gaussian",5,1));

    % templo - cbcr <- quando existe um contraste vísivel da cor dos
    % objetos
    % aviao - luminosidade ou RGB - melhor quando o fator de maior
    % diferenca e' a luminosidade
    if channel == 0
        y=imsegkmeans(cbcr,k);
    elseif channel == 1
        y=imsegkmeans(lum,k);
    else
        y=imsegkmeans(I,k);
    end
end







%%%%%%%%%%%%%%%%%%% 
% outras funcoes
% bwconncomp() 
% -> conta o numero de objetos existentes numa imagem,
% recorrendo a crite'rios de conectividade entre pixeis 2D-(4,8) ou 
% 3D-(6,18,26)

% labelmatrix()
% -> permite criar uma label para cada objeto obtido da funcao bwconncomp

% label2rgb()
% -> transforma o resultado da labelmatrix numa imagem RGB para mais facil
% visualizacao das regioes


% kmeans
% -> divide o espaco de dados por clustering em k conjuntos

% imsegkmeans
% -> segmentacao baseada em clustering






