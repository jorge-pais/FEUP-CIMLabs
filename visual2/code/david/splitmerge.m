function g = splitmerge(f, mindim, fun)
    %UNT?TLED Summary of this function goes here
    %   split and merge algorithm segments image F.

    Q=2^nextpow2(max(size(f)));
    [M, N]=size(f);
    f=padarray(f,[Q-M, Q-N], 'post');
    Z=qtdecomp(f, @split_test, mindim, fun);
    Lmax=full(max(Z(:)));
    g=zeros(size(f));
    MARKER=zeros(size(f));
    for K=1:Lmax
        [vals, r, c]=qtgetblk(f, Z, K);
        if ~isempty(vals)
            for I=1:length(r)
                xlow=r(I); ylow=c(I);
                xhigh=xlow+K-1;
                yhigh=ylow+K-1;
                region=f(xlow:xhigh, ylow:yhigh);
                flag=fun(region);
                if flag
                    g(xlow:xhigh, ylow:yhigh)=1;
                    MARKER(xlow, ylow)=1;
                end
            end
        end
    end
    g=bwlabel(imreconstruct(MARKER,g));
    g=g(1:M, 1:N);
end

function v=split_test(B, mindim, fun)
    k=size(B,3);
    v(1:k)=false;
    for I=1:k
        quadregion=B(:,:,I);
        if size(quadregion, 1)<= mindim
            v(I)=false;
            continue
        end
        flag=fun(quadregion);
        if flag
            v(I)=true;
        end
    end
end