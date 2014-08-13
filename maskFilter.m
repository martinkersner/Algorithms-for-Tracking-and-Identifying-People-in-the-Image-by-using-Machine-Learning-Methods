%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-13-2014
%%
%% Filtering image by mask.
%%
%% TODO: automatically estimate threshold
%%
%% O   filtered output image
%% I   examined image
%% M   mask of background
%% T   threshold
function O = maskFilter(I, M, T=60)
  z = zeros(size(I));

  % filtering background
  z_tmp = I .- M;

  % threholding and creating new mask
  z(z_tmp > T) = 1;
  z(z_tmp <= T) = 0;

  % employing new mask
  O = I .* z;
endfunction
