#' Create a scenario for SIM modelling based on costs, production and attraction variables
#'
#' @param sim_obj A SIM object
#' @param cost A cost data frame with origin, destination and cost columns
#' @param production A production data frame - origin column plus production variable columns
#' @param attraction A attraction data frame - destinmation column plus attraction variable columns
#' @return A scenartio data frame merging the information above
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count) -> mdl
#' eastmid_ttw %>% add_sim_fitted(mdl)
#' @export
sim_scenario <- function(sim_obj,cost=NULL,production=NULL,attraction=NULL) {
  vars <- attr(sim_obj,"vars")
  if (is.null(cost)) {
    res <- sim_obj$data %>% select(orig,dest,cost) }
  else {
    res <- cost %>% transmute(orig=!!(vars$orig),dest=!!(vars$dest),cost=!!(vars$cost))
  }
  if (!is.null(production)) res %>% left_join(production %>% rename(orig=!!(vars$orig))) -> res
  if (!is.null(attraction)) res %>% left_join(attraction %>% rename(dest=!!(vars$dest))) -> res
  return(res)
}

