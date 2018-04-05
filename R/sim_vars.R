#' Return the quosures of the SIM variables for a given sim object
#'
#' @param sim_obj A 'sim' object
#' @return A list of quosures
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count) -> mdl
#' sim_vars(mdl)
sim_vars <- function(sim_obj) {
  return(attr(sim_obj,"vars"))
}



