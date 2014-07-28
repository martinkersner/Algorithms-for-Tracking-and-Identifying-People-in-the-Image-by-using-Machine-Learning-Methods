%% eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
%% Martin Kersner, m.kersner@gmail.com
%% 07-28-2014
%%
%% Generates Blocks.
%% 
%% Explanatory notes:
%% generateRectangle(IMAGE, BLOCK, OVERLAP)
%% generateRectangle([90, 90], [45, 45], [40, 40])
%%
%% IMAGE     = size of picture
%%           = [row, column]
%% BLOCK     = size of generated blocks
%%           = [row, column]
%% OVERLAP   = size of overlap blocks 

function [coordinates] = generateBlocks(image, block, overlap)
  % size of picture
  img_row = image(1,1);
  img_column = image(1,2);

  % size of generating block 
  block_row = block(1,1);
  block_column = block(1,2);

  % size of overlap blocks
  over_row = overlap(1,1);
  over_column = overlap(1,2);

  % matrix of result coordinates
  coordinates=[];

  % settings of stepping
  step_row = block_row;
  step_column = block_column;

  if (over_row != 0)
    step_row = over_row;
  endif

  if (over_column != 0)
    step_column = over_column;
  endif

  for row=1:step_row:img_row
    for column=1:step_column:img_column
        rdr = row + block_row - 1;
        rdc = column + block_column - 1;

      if (row <= img_row && column <= img_column && rdr <= img_row && rdc <= img_column)
        coor = [row, column; rdr, rdc]; % saving found blocks
        coordinates = [coordinates; coor];  % insert found blocks into main matrix
      else
        break % block is out of size picture
      endif

    endfor
  endfor

endfunction
