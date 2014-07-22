%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-22-2014
%%
%% Returns the weight of part of histogram.
%% L left position in histogram
%% R right position in histogram
%% H histogram
function V = get_weight(L, R, H)
  V = sum(H(L:R));

endfunction
