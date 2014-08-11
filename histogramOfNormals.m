%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-11-2014
%%
%% Computes feature vector from the tangent and bitangent, which are cross 
%% producted, of given image.
%%
%% F     feature vector
%% I     examined image
%% B     coordinated of blocks of image
%%       height of the block has to be 3 due to cross product
%% BIN   number of bins of histogram
function F = histogramOfNormals(I, B, BIN)
  so1 = [1; 2; 1];
  so2 = [-1 0 1];
  F = [];

  % Sobel operator
  so_x = so1 * so2;
  so_y = (so1 * so2(end:-1:1))';

  % compute tangent and bitangent
  t = conv2(double(I), so_x, 'same');
  b = conv2(double(I), so_y, 'same');

  % split to blocks
  for i = 1:2:size(B)
    tb = t(B(i,1):B(i+1,1), B(i,2):B(i+1,2));
    bb = b(B(i,1):B(i+1,1), B(i,2):B(i+1,2));

    % cross product
    c = cross(tb, bb);
    F = [F, hist(c(:), BIN)];
  endfor
endfunction

