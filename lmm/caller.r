library(rstan)

# set path
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# generate simulation data
set.seed(123)
N <- 100
K <- 3
J <- 10
X <- matrix(rnorm(N * K), nrow = N, ncol = K)
group <- sample(1:J, N, replace = TRUE)
beta_true <- c(2, -1, 0.5)
u_true <- rnorm(J, 0, 2)
sigma_true <- 1
y <- X %*% beta_true + u_true[group] + rnorm(N, 0, sigma_true)

data_list <- list(
  N = N,
  K = K,
  J = J,
  group = group,
  X = X,
  y = as.vector(y)
)

# load linear mixed model
lmm_model_file = 'lmm.stan'

# run
fit_lmm <- stan(
  file = lmm_model_file,
  data = data_list,
  iter = 2000,            # iteration times
  chains = 4              # chains number by default
)

# result
summary(fit_lmm)
