## eClub Summer Camp 2014, www.eclub.cvutmedialab.cz
## Martin Kersner, m.kersner@gmail.com
## 08-07-2014
##
## Computes penalized accuracy.
##
## CM confusion matrix
import numpy as np

def getPenAcc(CM):
  CC = [[1,   0.5,  1,    0.5,  1,    1,    1,    2], 
        [0.5, 1,    0.5,  1,    1,    1,    2,    1],
        [1,   0.5,  1,    1,    0.5,  2,    1,    1],
        [0.5, 1,    1,    1,    2,    0.5,  1,    0.5],
        [1,   1,    0.5,  2,    1,    1,    1,    1],
        [1,   1,    2,    0.5,  1,    1,    0.5,  1],
        [1,   2,    1,    1,    1,    0.5,  1,    0.5],
        [2,   1,    1,    1,    0.5,  1,    0.5,  1]];

  CC = np.asarray(CC)
  CC = CC * CM;
  Acc = 0

  for i in range(0, CC.shape[0]):
    CC_slice = CC[:,i]
    TP = CC_slice[i] 
    FP = sum(CC_slice) - TP

    TPFP = TP + FP

    if TPFP != 0:
      Acc_tmp = TP / TPFP
      if Acc_tmp != 0:
        Acc += Acc_tmp

  Acc = Acc/CC.shape[0]

  return Acc
