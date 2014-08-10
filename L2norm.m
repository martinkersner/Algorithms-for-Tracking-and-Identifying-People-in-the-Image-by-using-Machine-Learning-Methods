%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 08-08-2014
%%
%% Computes L2-norm employed by HOG.
%%
%% N  normalized vector
%% V  unnormalized vector
%% E  small constant
function N = L2norm(V, E=0.01)
   N = V ./ sqrt(norm(double(V), 2).^2 + E^2);
endfunction
