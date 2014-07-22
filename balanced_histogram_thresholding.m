%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-22-2014
%%
%% Balanced Histogram Threshold
%% inspired by http://en.wikipedia.org/wiki/Balanced_histogram_thresholding
%% I input BW image
%% BIN number of bins for histogram
%% Returns the threshold where the binary image should be separated.
function threshold = balanced_histogram_thresholding(I, BIN)
  [h, hi] = hist(reshape(I, size(I,1) * size(I,2), 1), BIN);

  i_s = 1;
  i_e = size(h, 2);

  while (i_s <= i_e)
    i_m = uint8(i_e / 2.0);
    w_l = get_weight(1, i_m, h);
    w_r = get_weight(i_m + 1, i_e, h);

    if (w_r > w_l) % right side is heavier
      w_r -= h(i_e);
      i_e--;

    else % left side is heavier
      w_l -= h(i_s); 
      i_s++;
    endif
  endwhile

  if i_m > size(hi,2)
    threshold = hi(size(hi,2))
  else
    threshold = hi(i_m);
  endif
endfunction 
