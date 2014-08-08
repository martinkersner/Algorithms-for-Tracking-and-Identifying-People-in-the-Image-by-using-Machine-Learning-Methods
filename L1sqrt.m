%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-08-2014
%%
%% Computes L1-sqrt employed by HOG.
%%
%% N  normalized vector
%% V  unnormalized vector
%% E  small constant
function N = L1sqrt(V, E)
   N = sqrt(V ./ norm(V, 1) + E);
 endfunction

