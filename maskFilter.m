%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-13-2014
%%
%% Filtering image by mask.
%%
%% O   filtered output image
%% I   examined image
%% M   mask of background
%% B   number of bins
function O = maskFilter(I, M, B=20)
  z = zeros(size(I));

  % filtering background
  z_tmp = I .- M;

  % histogram
  [h hi] = hist(X(:), B);

  % vectors which are later employed to find local minimum
  % right shift, left shift, no shift
  rs = h(1:end-2);
  ls = h(3:end);
  ns = h(2:end-1);

  % finding local minimum; denoted as 1
  lm = (ns-rs) .* (ns-ls);
  lm(lm >= 0) = 1;
  lm(lm < 0) = 0;

  % find positions of all local minimum
  pos_v = find(lm);
  pos = pos_v(1);

  % get the last position of the first continuous series of local minimums
  for i = pos_v(2:end)
    if ((pos+1) == i)
      pos = i;
    else
      break
    endif
  endfor

  % Found threshold is increased by one due to trimming of histogram 
  % values in one of previous step.
  T = hi(pos + 1)

  % threholding and creating new mask
  z(z_tmp > T) = 1;
  %z(z_tmp <= T) = 0;

  % employing new mask
  O = I .* z;
endfunction
