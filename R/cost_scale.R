#' Return the cost scale of a sim object
#'
#' @param sim_obj A 'sim' object derived from that frame
#' @return The cost scale of the sim object
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count) -> mdl
#' cost_scale(mdl)
#' @export
cost_scale <- function(sim_obj) as.numeric(-1.0 / coef(sim_obj)["cost"])