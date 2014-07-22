%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-22-2014
%%
%% Otsu's method
%% inspired by http://en.wikipedia.org/wiki/Otsu%27s_method
%% I input BW image
%% B number of bins for histogram
%% Returns the threshold where the binary image should be separated.
function threshold = otsus_method(I, B)
  B = 256;
  total = size(I, 1) * size(I, 2);
  
  % Compute histogram and probabilities of each intensity level
  [h, hi] = hist(reshape(I, total, 1), B);

  i = 1:B;
  s = sum(i.*h(i));

  % Set up initial
  wB = 0.0;
  wF = 0.0;
  mB = 0.0;
  mF = 0.0;

  sumB = 0;
  max = 0.0;

  % Step through all possible thresholds i = 1...maximum intensity
  % m Mean
  % w Weight
  % B Background
  % F Foreground
  for i = 1:B
    wB += h(i);

    if (wB == 0)
      continue;
    endif

    wF = total - wB;

    if (wF == 0)
      break;
    endif

    sumB += i * h(i);

    mB = sumB / wB;
    mF = (s - sumB) / wF;

    between = wB * wF * (mB - mF)^2;

    if (between >= max) 
      t1 = i;

      if (between > max)
        t2 = i;
      endif
              
      max = between;            
    endif
  endfor

  threshold = uint8((t1 + t2)/2.0);
endfunction
