%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-11-2014
%%
%% Computes Histogram of Normals. 
%% producted, of given image.
%%
%% F     feature vector
%% I     examined image
%% B     coordinated of blocks of image
%% BIN   number of bins of histogram
function F = histogramOfNormals(I, B, BIN)
  so1 = [1; 2; 1];
  so2 = [-1 0 1];
  F = [];

  % Sobel operator
  so_x = so1 * so2;
  so_y = (so1 * so2(end:-1:1))';

  % compute tangent and bitangent
  d_x = double(conv2(double(I), so_x, 'same'));
  d_y = double(conv2(double(I), so_y, 'same'));

  % azimut angle
  phi = atan(d_x ./ d_y);
  
  % zenit angle
  theta = atan(sqrt(d_x.^2 + d_y.^2));

  % split to blocks
  for i = 1:2:size(B)
    phi_b = phi(B(i,1):B(i+1,1), B(i,2):B(i+1,2));
    theta_b = theta(B(i,1):B(i+1,1), B(i,2):B(i+1,2));

    % 2D histogram
    [h, hi] = hist3([phi_b(:), theta_b(:)], [BIN BIN]);

    F = [F, hist(h(:), BIN)];
  endfor
endfunction
