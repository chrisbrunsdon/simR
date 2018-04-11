#' Extract SIM model coefficients relating to origin
#'
#' @param sim_obj A 'sim' object
#' @return A tibble with a list of coefficient values - either a balancing term for each area or
#' regression coefficients for the variables used to measure productiveness of each area.
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% doubly_constrained_sim(From,To,Dist,Count) -> mdl
#' mdl %>% orig_coefs
#' @export
orig_coefs <- function(sim_obj) {
  tp <- attr(sim_obj,"type")
  sim_obj$data$orig%>%unique -> orig_names
  if (tp %in% c("orig","dbl")) {
    coef_choice <- grepl("^orig",names(coef(sim_obj)))
    coefs <- coef(sim_obj)[coef_choice]
    names(coefs) <- sub("orig","",names(coefs))
    extra <- 0
    names(extra) <- orig_names[!orig_names %in% names(coefs)]
    coefs <- c(extra,coefs)
    return(tibble(orig=names(coefs),orig_coef=exp(coefs)))
  }
  if (tp == "dest") {
    coef_choice <- attr(sim_obj,"pr")
    coefs <- coef(sim_obj)[coef_choice]
    return(tibble(orig_var=names(coefs),orig_coef=exp(coefs)))
  }
  coef_choice <- attr(sim_obj,"prat")$orig
  coefs <- coef(sim_obj)[coef_choice]
  return(tibble(orig_var=names(coefs),orig_coef=exp(coefs)))
}

#' Extract SIM model scores relating to origin
#'
#' @param sim_obj A 'sim' object
#' @return A tibble with a list of productiveness scores - either based on balancing terms for
#' each area,  or on the basis of the productiveness variables,  depending on whether origin constraints
#' were used.
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% dest_constrained_sim(From,To,eastmid_ec_act,Dist,Count) -> mdl
#' mdl %>% orig_scores
#' @export
orig_scores <- function(sim_obj) {
  tp <- attr(sim_obj,"type")
  sim_obj$data$orig %>% unique -> dest_names
  if (tp %in% c("orig","dbl")) {
    coef_choice <- grepl("^orig",names(coef(sim_obj)))
    coefs <- coef(sim_obj)[coef_choice]
    names(coefs) <- sub("orig","",names(coefs))
    extra <- 0
    names(extra) <- orig_names[!orig_names %in% names(coefs)]
    coefs <- c(extra,coefs)
    return(tibble(orig=names(coefs),orig_score=exp(coefs)))
  }
  if (tp == "dest") {
    coef_choice <- attr(sim_obj,"pr")
    coefs <- coef(sim_obj)[coef_choice]
    sim_obj$data %>% group_by(orig) %>% summarise_all(first) -> tdf
    os <- as.numeric(as.matrix(tdf[,coef_choice]) %*% coefs)
    return(tibble(orig=tdf$orig,orig_score=exp(os)))
  }
  coef_choice <- attr(sim_obj,"prat")$orig
  coefs <- coef(sim_obj)[coef_choice]
  sim_obj$data %>% group_by(orig) %>% summarise_all(first) -> tdf
  os <- as.numeric(as.matrix(tdf[,coef_choice]) %*% coefs)
  return(tibble(orig=tdf$dest,orig_score=exp(os)))
}