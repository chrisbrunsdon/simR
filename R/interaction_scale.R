#' Return the interaction scale of a sim object
#'
#' @param sim_obj A 'sim' object derived from that frame
#' @return The interaction scale of the sim object
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count) -> mdl
#' interaction_scale(mdl)
#' @export
interaction_scale <- function(sim_obj) exp(as.numeric(coef(sim_obj)["(Intercept)"]))