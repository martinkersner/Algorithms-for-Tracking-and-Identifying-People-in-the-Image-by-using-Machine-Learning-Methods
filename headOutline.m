%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-12-2014
%%
%% Finds a head in the normalized image, draws an outline around it
%% and return coordinates of head center. We assume that given shapes have
%% already been preselected. We do not deal with issues such as control 
%% of size of shape.
%%
%% O   output image
%% X   X-axis coordinate (collumns)
%% Y   Y-axis coordinate (rows)
%% I   examined image
%% B   number of bins
%% P   position of bin with decision threshold
function [O, X, Y] = headOutline(I, B=20, P=2)
  [h, hi] = hist(I, B);
  v_h = hi(end:-1:1);
  t = v_h(P);
  
  % thresholding
  h = uint8(I > t);

  % finds edges of head shape
  e = edge(h, 'Canny');

  % binary mask
  bm = zeros(size(I));
  bm(h > 0) = 1;

  % centroid coordinates of 'head'
  c = regionprops(bm, 'Centroid');
  X = uint16(c.Centroid(1));
  Y = uint16(c.Centroid(2));

  % draw red edges around head in input image
  rgb_e = 255 * e;
  rgb_I = gray2rgb(I);
  rgb_I(:,:,1) += rgb_e;
  rgb_I(:,:,2) -= rgb_e;
  rgb_I(:,:,3) -= rgb_e;
  
  O = rgb_I;
endfunction
