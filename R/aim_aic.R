#' Return the AIC of a SIM model
#'
#' @param sim_obj A 'sim' object
#' @return AIC of the SIM
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count) -> mdl
#' sim_aic(mdl)
#' @export
sim_aic <- function(sim_obj) return(sim_obj$aic)

