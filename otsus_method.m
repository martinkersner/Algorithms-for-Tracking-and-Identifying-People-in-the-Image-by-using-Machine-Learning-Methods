%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-22-2014
%%
%% Otsu's method
%% inspired by http://en.wikipedia.org/wiki/Otsu%27s_method
%%
%% Explanatory notes of variables:
%% m Mean
%% w Weight
%% B Background
%% F Foreground
%% mx Maximum
%% 
%% Parameters: 
%% I input BW image
%% Returns the threshold where the binary image should be separated.
function threshold = otsus_method(I)
  BIN = 256;
  total = size(I, 1) * size(I, 2);
  
  % Compute histogram and probabilities of each intensity level
  [h, hi] = hist(reshape(I, total, 1), BIN);

  i = 1:BIN;
  s = sum(i.*h(i));

  % Set up initial weights and means
  wB = 0.0;
  wF = 0.0;
  mB = 0.0;
  mF = 0.0;

  sumB = 0;
  mx = 0.0;

  % Step through all possible thresholds i = 1...maximum intensity
  for t = 1:BIN
    wB += h(t);

    if (wB == 0)
      continue;
    endif

    wF = total - wB;

    if (wF == 0)
      break;
    endif

    sumB += t * h(t);

    mB = sumB / wB;
    mF = (s - sumB) / wF;

    % Maximizing inter-class variance
    sigma = wB * wF * (mB - mF)^2;

    % Compute two maximas (and two corresponding thresholds)
    if (sigma > mx) 
      mx = sigma;            
      threshold = t;
    endif
  endfor

endfunction
