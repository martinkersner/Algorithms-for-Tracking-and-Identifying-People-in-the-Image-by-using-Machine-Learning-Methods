%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 07-28-2014
%%
%% Local Binary Patterns
%%
%% Explanatory notes:
%% |v1|v2|v3|                                                            
%% |v8|c |v4|
%% |v7|v6|v5|
%%         
%% ((vi - c) > 0) * 2^i

function [L] = lbp(X)
    K = zeros(3, 3, 8);
    K(:,:,8) = [1 0 0; 0 0 0; 0 0 0];
    K(:,:,7) = [0 1 0; 0 0 0; 0 0 0];
    K(:,:,6) = [0 0 1; 0 0 0; 0 0 0];
    K(:,:,5) = [0 0 0; 1 0 0; 0 0 0];
    K(:,:,4) = [0 0 0; 0 0 1; 0 0 0];
    K(:,:,3) = [0 0 0; 0 0 0; 1 0 0];
    K(:,:,2) = [0 0 0; 0 0 0; 0 1 0];
    K(:,:,1) = [0 0 0; 0 0 0; 0 0 1];

    L = zeros(size(X));
    w = 1;

    for i = 1:8
        L = L + (w * (X <= conv2(double(X), double(K(:,:,i)), 'same')));
        w = w * 2;
    endfor
    
endfunction
