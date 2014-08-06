%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-06-2014
%%
%% Find end coordinates of line from given start coordinates angle.
function [X_end Y_end] = degToCoor(X, Y, A, H, W)

    % equality for 360 and 0 degrees
    if (A == 360)
      A = 0;
    endif

    % the first quadrant
    if (A > 0 && A < 90)
      dx = H - X;
      dy = dx / tan(degToRad(A));
      X_end = 1;

    % the second quadrant
    elseif (A > 90 && A < 180)
      A = A - 90;
      dx = H - X;
      dy = -dx * tan(degToRad(A));
      X_end = 1;

    % the third quadrant
    elseif (A > 180 && A < 270)
      A = A - 180;
      dx = H - X;
      dy = -dx / tan(degToRad(A));
      X_end = H;

    % the fourth quadrant
    elseif (A > 270 && A < 360)
      A = A - 270;
      dx = H - X;
      dy = dx * tan(degToRad(A));
      X_end = H;

    endif 

    if (A == 0)
      dy = W - Y;
      X_end = X;
    elseif (A == 90)
      dy = 0;
      X_end = 1;
    elseif (A == 180)
      dy = -Y + 1;
      X_end = X;
    elseif (A == 270)
      dy = 0;
      X_end = H;
    endif

    Y_end = Y + dy;

    % the first quadrant
    if (X_end == 1 && Y_end > W) 
      tmp = Y_end - W;
      X_end = tmp * tan(degToRad(A));
      Y_end = W;

    % the second quadrant
    elseif (X_end == 1 && Y_end <= 0) 
      X_end = abs(Y_end) / tan(degToRad(A));
      Y_end = 1;

    % the second quadrant
    elseif (X_end == H && Y_end <= 0) 
      dx = abs(Y_end) * tan(degToRad(A));
      X_end = X_end - dx;
      Y_end = 1;

    % the fourth quadrant
    elseif (X_end == H && Y_end > W) 
      tmp = Y_end - W;
      dx = tmp / tan(degToRad(A));
      X_end = X_end - dx;
      Y_end = W;

    endif

    % postprocessing of output values
    if X_end < 1
      X_end = 1;
    else
      X_end = round(X_end);
    endif

    if Y_end < 1
      Y_end = 1;
    else
      Y_end = round(Y_end);
    endif

endfunction
