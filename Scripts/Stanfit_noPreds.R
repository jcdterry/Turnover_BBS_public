
RUN_NAME <- 'NoPreds1'

### Same priors as for Human2, but this time without predictors

sessionInfo()

Start<- Sys.time()
print('Starting at:')
Start

## Load packages
library(Matrix)
library(tidyverse)
library(brms)

cat(getwd())
setwd('~/GitHub/TurnoverClassify/Scripts/')

RunID =  as.numeric(Sys.getenv("SGE_TASK_ID"))

## Load Data
Average_Curves<- read_csv('../Data/All_Average_Curves.csv')
STATS_select  <- read_csv('../Data/STATS_select_SCALED.csv')
BCRsToFit     <- read_csv('../Data/BCRsToFit.csv')

## Select Focal BCR
Select_BCR = BCRsToFit$BCR[RunID]

Average_Curves %>%
  left_join(STATS_select, by = "TransectID") %>%
  filter( !is.na(Gamma_Div_Ebird))%>%
  filter(BCR == Select_BCR) -> Data_filt

Data_filt

### Building STAN model

prior_set_logitd <- prior(normal(0.8, 1), lb=0, ub = 1, nlpar = "om0") +
  prior(normal(-2.3, 1), lb=-4,ub = -1, nlpar = "logL0")+
  prior(normal(0, 1), nlpar = "logitd0")+
  prior(normal(0,2), class = "sd", group = "TransectID", nlpar = "om0")+
  prior(normal(0,1), class = "sd", group = "TransectID", nlpar = "logL0")+
  prior(normal(0,2), class = "sd", group = "TransectID", nlpar ="logitd0")

Model<- brm(bf(y|se(se, sigma =TRUE)~ (om0)*( (1-inv_logit(logitd0)) * exp(-exp(logL0)*x)+inv_logit(logitd0)),
               om0+logitd0+logL0  ~ 1+ (1|TransectID), 
               sigma   ~ 1 +(1|TransectID), 
               nl = TRUE),
            iter = 10000, thin =5,
            data =  Data_filt,
            prior = prior_set_logitd,
            cores =4)

Model
dir.create(path = paste0('../ModelFits/',RUN_NAME,'/'), showWarnings = FALSE)
save(Model, file = paste0('../ModelFits/',RUN_NAME,'/Model_BCR', Select_BCR))

######
## Ending material
print('Finishing at:')
Sys.time()

print('Total time:')
Sys.time() - Start
