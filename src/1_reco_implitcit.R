library(Matrix)
library(sparsio)
library(reco)

m = read_svmlight("~/datasets/lastfm360.svm")
m = m$x

N_ITER = 3
RANK = 128L
als = ALS$new(rank = RANK, lambda = 0.0, feedback = "implicit",
              init_stdv = 0.01, n_threads = 8,
              # solver ="conjugate_gradient",
              solver ="cholesky",
              cg_steps = 3L)
RhpcBLASctl::blas_set_num_threads(1)

t1 = Sys.time()
futile.logger::flog.info("start")
temp = als$fit_transform(x = m, n_iter = N_ITER, convergence_tol = -1, n_threads = 8)

difftime(Sys.time(), t1, units = "sec")
