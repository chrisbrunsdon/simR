#' Print method for a 'sim' object
#'
#' @param sim_obj A 'sim' object
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count)
#' @export
print.sim <- function(sim_obj,...) {
  cat("Spatial Interaction Model\n=========================\n\n")
  cat("Variables\n---------\n")
  vars <- sim_vars(sim_obj)
  cat("orig = ",rlang::quo_text(vars$orig),"\n")
  cat("dest = ",rlang::quo_text(vars$dest),"\n")
  cat("cost = ",rlang::quo_text(vars$cost),"\n")
  cat("intr = ",rlang::quo_text(vars$intr),"\n")
  cat("---------------------\n\n")
  cat("Model Type:",sim_type_name[attr(sim_obj,"type")],"\n")
  cat("Cost Denominator Parameter",sprintf("%6.2f",cost_scale(sim_obj)),"\n")
  cat("Cost Half Life            ",sprintf("%6.2f",cost_half_life(sim_obj)),"\n")
  cat("---------------------\n\n")
  if ("orig" %in% names(attr(sim_obj,'prat'))) cat("Production Variables: ",paste(attr(sim_obj,'prat')$orig,collapse=','),"\n")
  if ("dest" %in% names(attr(sim_obj,'prat'))) cat("Attraction Variables: ",paste(attr(sim_obj,'prat')$dest,collapse=','),"\n")
  cat("AIC                       ",sim_obj$aic,"\n")
  cat("====================================\n")
}




