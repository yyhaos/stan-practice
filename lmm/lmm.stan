data {
  int<lower=1> N;          // number of observations
  int<lower=1> K;          // number of predictors
  int<lower=1> J;          // number of groups
  int<lower=1, upper=J> group[N];  // group indicator
  matrix[N, K] X;          // predictor matrix
  vector[N] y;             // outcome vector
}

parameters {
  vector[K] beta;          // fixed effects
  real<lower=0> sigma;     // residual standard deviation
  real<lower=0> sigma_group; // group-level standard deviation
  vector[J] u;             // group-level effects
}

model {
  // Priors
  beta ~ normal(0, 5);
  sigma ~ normal(0, 5);
  sigma_group ~ normal(0, 5);
  u ~ normal(0, sigma_group);

  // Likelihood
  y ~ normal(X * beta + u[group], sigma);
}
