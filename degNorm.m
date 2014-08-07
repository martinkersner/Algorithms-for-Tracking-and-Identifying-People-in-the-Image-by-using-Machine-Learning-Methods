%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-07-2014
%%
%% Normalizes the degree.
%%
%% D  degree
%% N  normalized degree
function N = degNorm(D)
  if (D == 360)
    D = 0;
  elseif D < 0
    D = 360 - D;
  else D > 360
    D = D - 360;
  endif
endfunction
