%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-06-2014
%%
%% Detection of People using Depth Image Data
%%
%% X position in x coordinates
%% Y position in y coordinates
%% A angle
%% H height
%% W width
function M = drawLine(X, Y, A, H, W)

  % control of arguments
  if H < 3
    H = 100;
  endif

  if W < 3
    W = 100;
  endif

  if X < 1
    X = 1;
  elseif X > H
    X = H;
  endif

  if Y < 1
    Y = 1;
  elseif Y > W
    Y = W;
  endif

  if A < 0
    A = 0;
  elseif A > 360
    A = 360;
  endif

  M_tmp = zeros(2*H, 2*W);
  X_m = H;
  Y_m = W;

  [x_end, y_end] = degToCoor(X_m, Y_m, A, 2*H, 2*W);

  [cx, cy] = bresenham(X_m, Y_m, x_end, y_end);

  for i = 1:size(cx)
    M_tmp(cx(i), cy(i)) = 1; 
  endfor

  x_tmp = H - X;
  y_tmp = W - Y;

  M = M_tmp(x_tmp:x_tmp+H-1, y_tmp:y_tmp+W-1);
endfunction
