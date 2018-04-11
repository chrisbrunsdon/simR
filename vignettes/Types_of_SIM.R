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


