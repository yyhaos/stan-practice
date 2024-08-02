library(rstan)

# set path
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# generate simulation data
set.seed(123)
response_data <- matrix(sample(0:1, 1000, replace = TRUE), nrow = 100, ncol = 10)
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
  iter = 2000,            # iteration times
  chains = 4              # chains number by default
)

# result
summary(fit)

# alpha[1]    3.551696e-01  0.2283305    0.07001756  1.971910e-01
# alpha[2]    3.102936e-01  0.1997346    0.06692220  1.698307e-01
# alpha[3]    3.847483e-01  0.3639491    0.08580479  2.048750e-01
# alpha[4]    5.252037e-01  0.3916122    0.10276227  2.761238e-01
# alpha[5]    4.042349e-01  0.2854470    0.08052350  2.043645e-01
# alpha[6]    7.755308e-01  0.7165200    0.13871760  3.817333e-01
# alpha[7]    2.639095e-01  0.1674916    0.06172327  1.448159e-01
# alpha[8]    3.277144e-01  0.2158461    0.07333229  1.772871e-01
# alpha[9]    3.150292e-01  0.2072756    0.06573551  1.768399e-01
# alpha[10]   4.297753e-01  0.2708203    0.09581482  2.348077e-01
# beta[1]     5.781304e-01  0.6387448   -0.84536200  2.182712e-01
# beta[2]    -3.071101e-01  0.6537233   -1.58545823 -7.437874e-01
# beta[3]     9.845662e-02  0.5743114   -0.92065521 -2.446583e-01
# beta[4]     5.099239e-01  0.5143264   -0.50360453  2.161012e-01
# beta[5]    -1.697935e-02  0.5869951   -1.25900282 -3.659752e-01
# beta[6]    -4.498667e-01  0.4280831   -1.36653378 -6.823628e-01
# beta[7]    -2.700602e-01  0.7172248   -1.80733751 -6.679047e-01
# beta[8]     7.520140e-02  0.6147561   -1.14922419 -2.889505e-01
# beta[9]     4.761853e-01  0.6054973   -0.69014187  7.513370e-02
# beta[10]   -2.001900e-01  0.5692931   -1.50685047 -5.169223e-01  

