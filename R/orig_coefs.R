#' Create a tbl with the
#'
#' @param df A data frame
#' @param sim_obj A 'sim' object derived from that frame
#' @param colname A reference to the name of the new column - defaults to 'fitted'
#' @return The data frame with an extra column for the fitted value
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count) -> mdl
#' eastmid_ttw %>% add_sim_fitted(mdl)
#' @export
orig_coefs <- function(sim_obj) {
  sim_obj$data$orig%>%unique -> orig_names
  coef_choice <- grepl("^orig",names(coef(sim_obj)))
  coefs <- coef(sim_obj)[coef_choice]
  names(coefs) <- sub("orig","",names(coefs))
  extra <- 0
  names(extra) <- orig_names[!orig_names %in% names(coefs)]
  coefs <- c(extra,coefs)
  tibble(orig=names(coefs),orig_term=exp(coefs))
}