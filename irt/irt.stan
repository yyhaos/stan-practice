data {
  int<lower=1> N;  // number of respondents
  int<lower=1> J;  // number of items
  array[N, J] int<lower=0, upper=1> y;  // response matrix
}
parameters {
  vector[N] theta;  // ability parameters
  vector<lower=0>[J] alpha;  // discrimination parameters
  vector[J] beta;  // difficulty parameters
}
model {
  alpha ~ lognormal(0, 1);  // prior for discrimination
  beta ~ normal(0, 1);  // prior for difficulty
  theta ~ normal(0, 1);  // prior for ability

  for (n in 1:N) {
    for (j in 1:J) {
      y[n, j] ~ bernoulli_logit(alpha[j] * (theta[n] - beta[j]));
    }
  }
}
