# export OPENBLAS_NUM_THREADS=1
import implicit
import numpy as np
import time

import logging
logging.basicConfig(level=logging.DEBUG)

from sklearn.datasets import load_svmlight_file
X, y = load_svmlight_file("/home/dselivanov/datasets/lastfm360.svm")

# initialize a model
model = implicit.als.AlternatingLeastSquares(
  factors=32, 
  regularization=0.0, 
  # use_cg=True, 
  use_cg=False,
  iterations=3, 
  calculate_training_loss=True, 
  num_threads=8)

start_time = time.time()
model.fit(X)
print("--- %s seconds ---" % (time.time() - start_time))
