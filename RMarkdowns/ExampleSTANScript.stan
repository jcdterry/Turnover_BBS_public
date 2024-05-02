// STAN script generated with brms 2.18.0 used to fit the similiarity decay
// curve. NB all fitting is done through brms, this script is here just for
// reference.


functions {
}
data {
  int<lower=1> N;  // total number of observations
  vector[N] Y;  // response variable
  vector<lower=0>[N] se;  // known sampling error
  int<lower=1> K_om0;  // number of population-level effects
  matrix[N, K_om0] X_om0;  // population-level design matrix
  int<lower=1> K_logitd0;  // number of population-level effects
  matrix[N, K_logitd0] X_logitd0;  // population-level design matrix
  int<lower=1> K_logL0;  // number of population-level effects
  matrix[N, K_logL0] X_logL0;  // population-level design matrix
  int<lower=1> K_betaoHM;  // number of population-level effects
  matrix[N, K_betaoHM] X_betaoHM;  // population-level design matrix
  int<lower=1> K_betaoCV;  // number of population-level effects
  matrix[N, K_betaoCV] X_betaoCV;  // population-level design matrix
  int<lower=1> K_betaoAL;  // number of population-level effects
  matrix[N, K_betaoAL] X_betaoAL;  // population-level design matrix
  int<lower=1> K_betaoGM;  // number of population-level effects
  matrix[N, K_betaoGM] X_betaoGM;  // population-level design matrix
  int<lower=1> K_betaoYS;  // number of population-level effects
  matrix[N, K_betaoYS] X_betaoYS;  // population-level design matrix
  int<lower=1> K_betaLHM;  // number of population-level effects
  matrix[N, K_betaLHM] X_betaLHM;  // population-level design matrix
  int<lower=1> K_betaLCV;  // number of population-level effects
  matrix[N, K_betaLCV] X_betaLCV;  // population-level design matrix
  int<lower=1> K_betaLAL;  // number of population-level effects
  matrix[N, K_betaLAL] X_betaLAL;  // population-level design matrix
  int<lower=1> K_betaLGM;  // number of population-level effects
  matrix[N, K_betaLGM] X_betaLGM;  // population-level design matrix
  int<lower=1> K_betadYS;  // number of population-level effects
  matrix[N, K_betadYS] X_betadYS;  // population-level design matrix
  int<lower=1> K_betadHM;  // number of population-level effects
  matrix[N, K_betadHM] X_betadHM;  // population-level design matrix
  int<lower=1> K_betadCV;  // number of population-level effects
  matrix[N, K_betadCV] X_betadCV;  // population-level design matrix
  int<lower=1> K_betadAL;  // number of population-level effects
  matrix[N, K_betadAL] X_betadAL;  // population-level design matrix
  int<lower=1> K_betadGM;  // number of population-level effects
  matrix[N, K_betadGM] X_betadGM;  // population-level design matrix
  int<lower=1> K_betaLYS;  // number of population-level effects
  matrix[N, K_betaLYS] X_betaLYS;  // population-level design matrix
  // covariate vectors for non-linear functions
  vector[N] C_1;
  vector[N] C_2;
  vector[N] C_3;
  vector[N] C_4;
  vector[N] C_5;
  vector[N] C_6;
  // data for group-level effects of ID 1
  int<lower=1> N_1;  // number of grouping levels
  int<lower=1> M_1;  // number of coefficients per level
  int<lower=1> J_1[N];  // grouping indicator per observation
  // group-level predictor values
  vector[N] Z_1_sigma_1;
  // data for group-level effects of ID 2
  int<lower=1> N_2;  // number of grouping levels
  int<lower=1> M_2;  // number of coefficients per level
  int<lower=1> J_2[N];  // grouping indicator per observation
  // group-level predictor values
  vector[N] Z_2_om0_1;
  // data for group-level effects of ID 3
  int<lower=1> N_3;  // number of grouping levels
  int<lower=1> M_3;  // number of coefficients per level
  int<lower=1> J_3[N];  // grouping indicator per observation
  // group-level predictor values
  vector[N] Z_3_logitd0_1;
  // data for group-level effects of ID 4
  int<lower=1> N_4;  // number of grouping levels
  int<lower=1> M_4;  // number of coefficients per level
  int<lower=1> J_4[N];  // grouping indicator per observation
  // group-level predictor values
  vector[N] Z_4_logL0_1;
  int prior_only;  // should the likelihood be ignored?
}
transformed data {
  vector<lower=0>[N] se2 = square(se);
}
parameters {
  vector<lower=0,upper=1>[K_om0] b_om0;  // population-level effects
  vector[K_logitd0] b_logitd0;  // population-level effects
  vector<lower=-4,upper=-1>[K_logL0] b_logL0;  // population-level effects
  vector[K_betaoHM] b_betaoHM;  // population-level effects
  vector[K_betaoCV] b_betaoCV;  // population-level effects
  vector[K_betaoAL] b_betaoAL;  // population-level effects
  vector[K_betaoGM] b_betaoGM;  // population-level effects
  vector[K_betaoYS] b_betaoYS;  // population-level effects
  vector[K_betaLHM] b_betaLHM;  // population-level effects
  vector[K_betaLCV] b_betaLCV;  // population-level effects
  vector[K_betaLAL] b_betaLAL;  // population-level effects
  vector[K_betaLGM] b_betaLGM;  // population-level effects
  vector[K_betadYS] b_betadYS;  // population-level effects
  vector[K_betadHM] b_betadHM;  // population-level effects
  vector[K_betadCV] b_betadCV;  // population-level effects
  vector[K_betadAL] b_betadAL;  // population-level effects
  vector[K_betadGM] b_betadGM;  // population-level effects
  vector[K_betaLYS] b_betaLYS;  // population-level effects
  real Intercept_sigma;  // temporary intercept for centered predictors
  vector<lower=0>[M_1] sd_1;  // group-level standard deviations
  vector[N_1] z_1[M_1];  // standardized group-level effects
  vector<lower=0>[M_2] sd_2;  // group-level standard deviations
  vector[N_2] z_2[M_2];  // standardized group-level effects
  vector<lower=0>[M_3] sd_3;  // group-level standard deviations
  vector[N_3] z_3[M_3];  // standardized group-level effects
  vector<lower=0>[M_4] sd_4;  // group-level standard deviations
  vector[N_4] z_4[M_4];  // standardized group-level effects
}
transformed parameters {
  vector[N_1] r_1_sigma_1;  // actual group-level effects
  vector[N_2] r_2_om0_1;  // actual group-level effects
  vector[N_3] r_3_logitd0_1;  // actual group-level effects
  vector[N_4] r_4_logL0_1;  // actual group-level effects
  real lprior = 0;  // prior contributions to the log posterior
  r_1_sigma_1 = (sd_1[1] * (z_1[1]));
  r_2_om0_1 = (sd_2[1] * (z_2[1]));
  r_3_logitd0_1 = (sd_3[1] * (z_3[1]));
  r_4_logL0_1 = (sd_4[1] * (z_4[1]));
  lprior += normal_lpdf(b_om0 | 0.8, 1)
    - 1 * log_diff_exp(normal_lcdf(1 | 0.8, 1), normal_lcdf(0 | 0.8, 1));
  lprior += normal_lpdf(b_logitd0 | logit(0.5), 1);
  lprior += normal_lpdf(b_logL0 | -2.3, 1)
    - 1 * log_diff_exp(normal_lcdf(-1 | -2.3, 1), normal_lcdf(-4 | -2.3, 1));
  lprior += normal_lpdf(b_betaoHM | 0, 0.5);
  lprior += normal_lpdf(b_betaoCV | 0, 0.5);
  lprior += normal_lpdf(b_betaoAL | 0, 0.5);
  lprior += normal_lpdf(b_betaoGM | 0, 0.5);
  lprior += normal_lpdf(b_betaoYS | 0, 0.5);
  lprior += normal_lpdf(b_betaLHM | 0, 0.5);
  lprior += normal_lpdf(b_betaLCV | 0, 0.5);
  lprior += normal_lpdf(b_betaLAL | 0, 0.5);
  lprior += normal_lpdf(b_betaLGM | 0, 0.5);
  lprior += normal_lpdf(b_betadYS | 0, 0.5);
  lprior += normal_lpdf(b_betadHM | 0, 0.5);
  lprior += normal_lpdf(b_betadCV | 0, 0.5);
  lprior += normal_lpdf(b_betadAL | 0, 0.5);
  lprior += normal_lpdf(b_betadGM | 0, 0.5);
  lprior += normal_lpdf(b_betaLYS | 0, 0.5);
  lprior += student_t_lpdf(Intercept_sigma | 3, 0, 2.5);
  lprior += student_t_lpdf(sd_1 | 3, 0, 2.5)
    - 1 * student_t_lccdf(0 | 3, 0, 2.5);
  lprior += normal_lpdf(sd_2 | 0, 1)
    - 1 * normal_lccdf(0 | 0, 1);
  lprior += normal_lpdf(sd_3 | 0, 0.5)
    - 1 * normal_lccdf(0 | 0, 0.5);
  lprior += normal_lpdf(sd_4 | 0, 0.1)
    - 1 * normal_lccdf(0 | 0, 0.1);
}
model {
  // likelihood including constants
  if (!prior_only) {
    // initialize linear predictor term
    vector[N] nlp_om0 = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_logitd0 = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_logL0 = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaoHM = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaoCV = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaoAL = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaoGM = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaoYS = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaLHM = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaLCV = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaLAL = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaLGM = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betadYS = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betadHM = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betadCV = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betadAL = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betadGM = rep_vector(0.0, N);
    // initialize linear predictor term
    vector[N] nlp_betaLYS = rep_vector(0.0, N);
    // initialize non-linear predictor term
    vector[N] mu;
    // initialize linear predictor term
    vector[N] sigma = rep_vector(0.0, N);
    nlp_om0 += X_om0 * b_om0;
    nlp_logitd0 += X_logitd0 * b_logitd0;
    nlp_logL0 += X_logL0 * b_logL0;
    nlp_betaoHM += X_betaoHM * b_betaoHM;
    nlp_betaoCV += X_betaoCV * b_betaoCV;
    nlp_betaoAL += X_betaoAL * b_betaoAL;
    nlp_betaoGM += X_betaoGM * b_betaoGM;
    nlp_betaoYS += X_betaoYS * b_betaoYS;
    nlp_betaLHM += X_betaLHM * b_betaLHM;
    nlp_betaLCV += X_betaLCV * b_betaLCV;
    nlp_betaLAL += X_betaLAL * b_betaLAL;
    nlp_betaLGM += X_betaLGM * b_betaLGM;
    nlp_betadYS += X_betadYS * b_betadYS;
    nlp_betadHM += X_betadHM * b_betadHM;
    nlp_betadCV += X_betadCV * b_betadCV;
    nlp_betadAL += X_betadAL * b_betadAL;
    nlp_betadGM += X_betadGM * b_betadGM;
    nlp_betaLYS += X_betaLYS * b_betaLYS;
    sigma += Intercept_sigma;
    for (n in 1:N) {
      // add more terms to the linear predictor
      nlp_om0[n] += r_2_om0_1[J_2[n]] * Z_2_om0_1[n];
    }
    for (n in 1:N) {
      // add more terms to the linear predictor
      nlp_logitd0[n] += r_3_logitd0_1[J_3[n]] * Z_3_logitd0_1[n];
    }
    for (n in 1:N) {
      // add more terms to the linear predictor
      nlp_logL0[n] += r_4_logL0_1[J_4[n]] * Z_4_logL0_1[n];
    }
    for (n in 1:N) {
      // add more terms to the linear predictor
      sigma[n] += r_1_sigma_1[J_1[n]] * Z_1_sigma_1[n];
    }
    for (n in 1:N) {
      // compute non-linear predictor values
      mu[n] = (nlp_om0[n] + nlp_betaoHM[n] * C_1[n] + nlp_betaoCV[n] * C_2[n] + nlp_betaoAL[n] * C_3[n] + nlp_betaoGM[n] * C_4[n] + nlp_betaoYS[n] * C_5[n]) * ((1 - inv_logit(nlp_logitd0[n] + nlp_betadHM[n] * C_1[n] + nlp_betadCV[n] * C_2[n] + nlp_betadAL[n] * C_3[n] + nlp_betadGM[n] * C_4[n] + nlp_betadYS[n] * C_5[n])) * exp( - exp(nlp_logL0[n] + nlp_betaLHM[n] * C_1[n] + nlp_betaLCV[n] * C_2[n] + nlp_betaLAL[n] * C_3[n] + nlp_betaLGM[n] * C_4[n] + nlp_betaLYS[n] * C_5[n]) * C_6[n]) + inv_logit(nlp_logitd0[n] + nlp_betadHM[n] * C_1[n] + nlp_betadCV[n] * C_2[n] + nlp_betadAL[n] * C_3[n] + nlp_betadGM[n] * C_4[n] + nlp_betadYS[n] * C_5[n]));
    }
    sigma = exp(sigma);
    target += normal_lpdf(Y | mu, sqrt(square(sigma) + se2));
  }
  // priors including constants
  target += lprior;
  target += std_normal_lpdf(z_1[1]);
  target += std_normal_lpdf(z_2[1]);
  target += std_normal_lpdf(z_3[1]);
  target += std_normal_lpdf(z_4[1]);
}
generated quantities {
  // actual population-level intercept
  real b_sigma_Intercept = Intercept_sigma;
}