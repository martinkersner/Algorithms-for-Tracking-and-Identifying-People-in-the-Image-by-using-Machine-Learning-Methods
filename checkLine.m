%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-06-2014
%%
%% Computes a rank of given line with respect to gradient.
%%
%% R   ranking of line
%% X   X coordinates of line
%% Y   Y coordinates of line
%% I   examined image 
function R = checkLine(X, Y, I)

  % initialization
  rv = [];
  gap = 1;
  count = 0;
  R = 0;

  for i = 1:size(X)
    rv = [rv, I(X(i), Y(i))];
  endfor
  
  % removing leading and trailing zeros
  rv = rv(find(rv, 1, 'first'):find(rv, 1, 'last'));

  % find zeros (=gaps) in vector
  z = find(rv == 0);

  % penalization of gaps
  % complete avoiding to them
  if (length(z) != 0)
    lv = z(1);

    for i = 1:size(z, 2)
      % gap exist => maximal penalization 0
      if (count >= gap)
        R = 0;
        return;
      endif

      % increasing size of gap
      if (abs(lv-z(i)) == 1)
        count += 1;
      else
        count = 0;
      endif

      lv = z(i);
    endfor
  endif

  % checking continous gradient of image in particular direction
  % comparing adjacent values
  rv1 = rv(2:size(rv,2));
  rv2 = rv(1:size(rv,2)-1);
  l = size(rv, 2)^2;

  R = l;
  %R = l/mean(abs(int16(rv1)-int16(rv2)));
endfunction
