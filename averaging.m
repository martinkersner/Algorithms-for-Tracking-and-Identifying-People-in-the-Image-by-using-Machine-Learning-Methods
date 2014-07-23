%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz/contact
%% Martin Kersner, m.kersner@gmail.com
%% 07-23-2014
%%
%% Computes average of neighbor pixels with BOX kernel.
%% I input image
%% S size of the box
%% F noise supressed image
function F = averaging(I, S)
  box = ones(S, S)./S^2;
  F = uint8(conv2(I, box, 'same'));
endfunction

