%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-12-2014
%%
%% Finds a head in the normalized image, draws an outline around it
%% and return coordinates of head center.
%%
%% O   output image
%% I   examined image
%% B   number of bins
%% P   position of bin with decision threshold
function O = headOutline(I, B=20, P=2)
  [h, hi] = hist(I, B);
  v_h = hi(end:-1:1);
  t = v_h(P);
  
  % thresholding
  h = uint8(I > t);

  % finds edges of head shape
  e = edge(h, 'Canny');

  % draw red edges around head in input image
  rgb_e = 255 * e;
  rgb_I = gray2rgb(I);
  rgb_I(:,:,1) += rgb_e;
  rgb_I(:,:,2) -= rgb_e;
  rgb_I(:,:,3) -= rgb_e;
  
  O = rgb_I;
endfunction
