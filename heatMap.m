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
function [H HB] = heatMap(H, Y, X, B)
  H(Y, X) += 1;

  fun = @(b) sum(b(:));
  HB = blockproc(H, [B B], fun, 'PadPartialBlocks', true);
endfunction
