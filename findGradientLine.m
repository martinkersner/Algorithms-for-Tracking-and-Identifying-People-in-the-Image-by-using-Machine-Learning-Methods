%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-06-2014
%%
%% Finds gradient line in the image data.
%%
%% G image with fake gradient line
%% A estimated angle
%% M mean ranking of selected line
%% I examined image
function [G A M] = findGradientLine(I)
  % initialization
  height = size(I, 1);
  width = size(I, 2);
  step = 10;
  range = 25;

  %%% THE FIRST STAGE
  % find a center of head
  maximum = max(max(I));
  m_I = I == maximum;
  s = regionprops(m_I, 'Centroid'); 
  pos = s.Centroid;
  xx = int16(pos(2));
  yy = int16(pos(1));

  % create first eight lines
  angles = [0:45:315];
  j = 0;

  for i = angles
    j += 1;
    [m(:,:,j), x_points, y_points] = drawLine(xx, yy, i, height, width);

    % evaluate
    r(j) = checkLine(x_points, y_points, I) * sum(sum(I.*m(:,:,j)));
  endfor

  r(r == Inf) = 0;
  [i, ix] = max(r);
  A = angles(ix);

  %%% THE SECOND STAGE
  angles_acc = [A-range:step:A+range];
  r = [];
  m = [];
  j = 0;

  for i = angles_acc
    % normalization of angles
    if i < 0
      i = 360 - i;
    endif

    j += 1;
    [m(:,:,j), x_points, y_points] = drawLine(xx, yy, i, height, width);

    %evaluate
    r(j) = checkLine(x_points, y_points, I) * sum(sum(I.*m(:,:,j)));
  endfor

  r(r == Inf) = 0;
  [i, ix] = max(r);
  A = angles_acc(ix);
  M = r(ix);

  % normalization of angles
  if A < 0
    A = 360 - A;
  endif

  G = I+256*m(:,:,ix);

endfunction
