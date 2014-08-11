%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-08-2014
%%
%% Computes Histogram of Oriented Gradients.
%%
%% F     vector of features
%% I     examined image
%% BIN   number of bins
%% C     size of cell
%% B     size of block (in measure of cells)
function F = hog(I, BIN=9, C=6, B=3, N=1)
  h = size(I, 1);
  w = size(I, 2);
  k = [-1, 0, 1];

  ir = reshape(I', 1, []);
  il = reshape(I, [], 1);

  cr = conv(ir, k, 'same');
  cl = conv(il, k', 'same');
  
  dx = reshape(cr, w, h)';
  dy = reshape(cl, h, w);

  % magnitudes
  r = sqrt(dx.^2 + dy.^2);

  % sign of gradient for y-axis is ignored
  a = atand(abs(dx) ./ dy);
  a = a + 180*(a < 0);

  step = uint8((180/BIN) + 1);
  histRange = 0:step:180;

  % split to cells
  fun = @(b) hist(b(:), [histRange]);
  cells = blockproc(I, [C C], fun, 'PadPartialBlocks', true);

  % split to blocks
  if (N == 2)
    fun = @(c) L2norm(c'(:)');
  else
    fun = @(c) L1sqrt(c'(:)');
  endif

  blocks = blockproc(cells, [B size(histRange, 2)*B], fun, 'PadPartialBlocks', true);

  F = blocks'(:)';
endfunction 
