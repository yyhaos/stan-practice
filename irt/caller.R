library(rstan)

# set path
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# generate simulation data
set.seed(123)

data(LSAT)
response_data <- LSAT
data_list <- list(
  N = nrow(response_data),
  J = ncol(response_data),
  y = response_data
)

# load irt model
irt_model_file = 'irt.stan'

# run
fit <- stan(
  file = irt_model_file,
  data = data_list,
  iter = 1000,            # iteration times
  chains = 4              # chains number by default
)

# result
summary(fit)
posterior_samples <- extract(fit)
alpha_samples <- posterior_samples$alpha
beta_samples <- posterior_samples$beta
alpha_mean <- apply(alpha_samples, 2, mean)
beta_mean <- apply(beta_samples, 2, mean)
print(data.frame(
  Item = 1:length(alpha_mean),
  Alpha = alpha_mean,
  Beta = beta_mean
))

# Item     Alpha         Beta
# 1     1 0.3562476  0.573130576
# 2     2 0.3224976 -0.331547392
# 3     3 0.3420833  0.075659254
# 4     4 0.5355919  0.528087382
# 5     5 0.4044883  0.002960797
# 6     6 0.8938660 -0.455421400
# 7     7 0.2660231 -0.254258885
# 8     8 0.3203382  0.082845637
# 9     9 0.3342486  0.500703907
# 10   10 0.4509933 -0.160473187
