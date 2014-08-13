%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-13-2014
%%
%% Detection of People using Depth Image Data.
%%
%% I     examined image
%% M     mask of bakground
%% MS    min size of shape
%% MSH   sub image height
%% MSW   sub image width
function D = detect(I, M, MS=300, MSH=100, MSW=110)
  D = gray2rgb(I);
  h = size(I, 1);
  w = size(I, 2);

  % filter by mask
  I_clear = maskFilter(I, M);

  % median filter
  I_clear = medfilt2(I_clear, [4 4]);

  % binary mask
  bm = zeros(size(M));
  bm(I_clear > 0) = 1;

  % number of people
  l = bwlabel(bm, 4);
  ppl_count = max(max(l));

  for i = 1:ppl_count
    % accepting only larger shapes
    if (size(find(l == i), 1) < MS)
      continue
    endif

    I_tmp = I_clear .* (l==i);
    [O, x, y] = headOutline(I_tmp);

    tl = [10 10];
    br = [h-10 w-10];


    if (x > tl(1) && x < br(2) 
        &&
        y > tl(1) && y < br(1))
      D = draw_square_red(D, y, x);
    else
      D = draw_square_blue(D, y, x);
    endif

  endfor
endfunction
