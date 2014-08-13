%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-13-2014
%%
%% Detection of People using Depth Image Data.
%%
%% H    heat map per pixel
%% HB   heat map per block
%% Y    Y-axis value
%% X    X-axis value
%% B    size of block
function [H HB] = heatMap(H, Y, X, B=5)
  if (X > 0 && Y > 0)
    H(Y, X) += 1;
  endif

  fun = @(b) sum(b(:)) * ones(B);
  HB = blockproc(H, [B B], fun, 'PadPartialBlocks', true);
endfunction
