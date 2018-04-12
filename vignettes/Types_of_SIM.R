## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, message=FALSE,
  comment = "#>"
)

## ----getready------------------------------------------------------------
library(simR)
library(tidyverse)
data(eastmid_ttw)
data(eastmid_empl)
eastmid_empl

## ----ocsim---------------------------------------------------------------
eastmid_ttw %>% orig_constrained_sim(From,To,eastmid_empl,Dist,Count) -> sim_o_const
sim_o_const

## ----dscores-------------------------------------------------------------
sim_o_const %>% dest_scores -> dest_sc
dest_sc 

## ----dsm-----------------------------------------------------------------
library(tmap)
library(sf)
eastmid_sf %>% left_join(dest_sc ,by=c('name'='dest')) -> eastmid_dest_sc
legend_style <- tm_legend(legend.position=c('right','bottom'),
                          legend.text.size=0.4)
tm_shape(eastmid_dest_sc) + tm_polygons(col='dest_score', title='Attraction') +
  legend_style


## ----meow----------------------------------------------------------------
eastmid_ttw %>% add_sim_fitted(sim_o_const) -> eastmid_ttw_fitted_oc
eastmid_ttw_fitted_oc

## ----fit_ok--------------------------------------------------------------
eastmid_ttw_fitted_oc %>% group_by(From) %>% 
  summarise(Count=sum(Count),Fitted=sum(Fitted))

## ----not_fit_ok----------------------------------------------------------
eastmid_ttw_fitted_oc %>% group_by(To) %>% 
  summarise(Count=sum(Count),Fitted=sum(Fitted))

## ----errs----------------------------------------------------------------
eastmid_ttw_fitted_oc %>% group_by(To) %>% 
  summarise(Count=sum(Count),Fitted=sum(Fitted)) %>%
  transmute(To,Error=100*(Count-Fitted)/Count) -> 
  eastmid_err
eastmid_sf %>% left_join(eastmid_err ,by=c('name'='To')) -> 
  eastmid_err_sf
tm_shape(eastmid_err_sf) + tm_polygons(col='Error',title='Error (%)') +
  legend_style + tm_style_col_blind()

