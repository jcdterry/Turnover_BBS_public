
RUN_NAME <- 'All_preds3'

### this identifying predictors of all the terms, and also includes 'Year Span'
## priors are set to be the same as in Human_all

sessionInfo()

Start<- Sys.time()
print('Starting at:')
Start

## Load packages
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

# Center the data

Data_filt %>%
  mutate(C_HM = Av_HMindex-mean(Av_HMindex),
         C_CV = CV_gpp_scaled-mean(CV_gpp_scaled),
         C_AL = AvRich_100-mean(AvRich_100),
         C_GM = Gamma_scaled-mean(Gamma_scaled),
         C_YS = Year_span-mean(Year_span)) -> Data_filt_CENTERED

### Building STAN model

prior_set <- prior(normal(0.8, 1), lb=0, ub = 1, nlpar = "om0") +
  prior(normal(-2.3, 1), lb=-4,ub = -1, nlpar = "logL0")+
  prior(normal(logit(0.5), 1), nlpar = "logitd0")+
  prior(normal(0, 0.5),nlpar = "betadHM") +
  prior(normal(0, 0.5),nlpar = "betadCV") +
  prior(normal(0, 0.5),nlpar = "betadAL") +
  prior(normal(0, 0.5),nlpar = "betadGM") +
  prior(normal(0, 0.5),nlpar = "betadYS") +
  prior(normal(0, 0.5),nlpar = "betaoHM") +
  prior(normal(0, 0.5),nlpar = "betaoCV") +
  prior(normal(0, 0.5),nlpar = "betaoAL") +
  prior(normal(0, 0.5),nlpar = "betaoGM") +
  prior(normal(0, 0.5),nlpar = "betaoYS") +
  prior(normal(0, 0.5),nlpar = "betaLHM") +
  prior(normal(0, 0.5),nlpar = "betaLCV") +
  prior(normal(0, 0.5),nlpar = "betaLAL") +
  prior(normal(0, 0.5),nlpar = "betaLGM") +
  prior(normal(0, 0.5),nlpar = "betaLYS") +
  prior(normal(0,1), class = "sd", group = "TransectID", nlpar = "om0")+
  prior(normal(0,0.1), class = "sd", group = "TransectID", nlpar = "logL0")+
  prior(normal(0,0.5), class = "sd", group = "TransectID", nlpar ="logitd0")


Model<- brm(bf(y|se(se, sigma =TRUE)~ (om0+betaoHM*C_HM + betaoCV*C_CV + betaoAL*C_AL + betaoGM*C_GM + betaoYS*C_YS)*(
                     (1-inv_logit(logitd0 +betadHM*C_HM + betadCV*C_CV + betadAL*C_AL + betadGM*C_GM + betadYS*C_YS)) *
                            exp(-exp(logL0+betaLHM*C_HM + betaLCV*C_CV + betaLAL*C_AL + betaLGM*C_GM + betaLYS*C_YS )*x)+
                        inv_logit(logitd0 +betadHM*C_HM + betadCV*C_CV + betadAL*C_AL + betadGM*C_GM + betadYS*C_YS)),
               om0+logitd0+logL0  ~ 1+ (1|TransectID), 
               betaoHM+betaoCV+betaoAL+betaoGM + betaoYS ~1,
               betaLHM+betaLCV+betaLAL+betaLGM + betadYS ~1,  
               betadHM+betadCV+betadAL+betadGM + betaLYS ~1,  
               sigma   ~ 1 +(1|TransectID), 
               nl = TRUE),
            iter = 10000, thin =5,
            data =  Data_filt_CENTERED,
            prior = prior_set,
            cores = 4)
Model
dir.create(path = paste0('../ModelFits/',RUN_NAME,'/'), showWarnings = FALSE)
save(Model, file = paste0('../ModelFits/',RUN_NAME,'/Model_BCR', Select_BCR))

######
## Ending material
print('Finishing at:')
Sys.time()

print('Total time:')
Sys.time() - Start
