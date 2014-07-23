%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-23-2014
%%
%% Computes average of neighbor pixels with GAUSSIAN kernel.
%% I input image
%% S size of the kernel
%% F noise supressed image
function F = gaussian(I, S, sigma)
  b = int16(S/2); % boundary
  [x y] = meshgrid(-b:b);
  g = exp(-x.^2/(2*sigma^2) - y.^2/(2*sigma^2));
  g = g./sum(g(:));

  F = uint8(conv2(I, g, 'same'));
endfunction
