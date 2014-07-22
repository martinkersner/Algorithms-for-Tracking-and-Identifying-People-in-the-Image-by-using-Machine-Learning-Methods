%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-22-2014
%%
%% K-Means
function kmeans(I, K)
  C = zeros(size(I), K);
  means = zeros(2, K);

  img_height = size(I, 1);
  img_width = size(I, 2);

  % Select K clusters
  for i = 1:K
    means(1, i) = uint16(rand*img_height);
    means(2, i) = uint16(rand*img_width);
  endfor

  % Condition of assingning
  % Euclidean lenght * squared difference of intensities

  I
  N stredu
  stred definovanej polohou (int) a intenzitou
  nekde musim ukladat ty urceny pixely, ty by byly v maticich stejne velkejch jako obrazek
endfunction
