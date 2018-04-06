## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- message=FALSE------------------------------------------------------
library(simR)
library(tidyverse)

## ----message=FALSE-------------------------------------------------------
library(sf)
library(tmap)

## ------------------------------------------------------------------------
data(eastmid_sf)
tm_shape(eastmid_sf) + tm_borders()

## ------------------------------------------------------------------------
data(eastmid_ttw)
eastmid_ttw

## ------------------------------------------------------------------------
eastmid_ttw %>% doubly_constrained_sim(From,To,Dist,Count)

## ------------------------------------------------------------------------
eastmid_ttw %>% doubly_constrained_sim(From,To,Dist,Count) -> sim_model

## ------------------------------------------------------------------------
eastmid_ttw %>% add_sim_fitted(sim_model) -> eastmid_ttw_fitted
eastmid_ttw_fitted

## ----fit_ok--------------------------------------------------------------
eastmid_ttw_fitted %>% group_by(To) %>% 
  summarise(Count=sum(Count),Fitted=sum(Fitted))

## ----map_it--------------------------------------------------------------
eastmid_ttw_fitted %>% filter(To=='Derby') -> to_derby
to_derby

## ------------------------------------------------------------------------
eastmid_sf %>% left_join(to_derby,by=c("name"="From")) -> to_derby_sf

## ------------------------------------------------------------------------
legend_style <- tm_legend(legend.position=c('right','bottom'),
                          legend.text.size=0.4)
tm_shape(to_derby_sf) + tm_polygons(col='Fitted',style='fisher') + legend_style
tm_shape(to_derby_sf) + tm_polygons(col='Count',style='fisher') + legend_style

