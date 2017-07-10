export OPENBLAS_NUM_THREADS=1
~/projects/qmf/bin/wals \
  --train_dataset=/home/dselivanov/datasets/lastfm360.txt \
  --regularization_lambda=0.0 \
  --confidence_weight=1 \
  --nepochs=3 \
  --nfactors=128 \
  --nthreads=8 \
  --user_factors=/home/dselivanov/datasets/qmf_user.txt \
  --item_factors=/home/dselivanov/datasets/qmf_item.txt