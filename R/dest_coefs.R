#' Extract SIM model coefficients relating to destination
#'
#' @param sim_obj A 'sim' object
#' @return A tibble with a list of coefficient values - either a balancing term for each area or
#' regression coefficients for the variables used to measure attractiveness of each area.
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% doubly_constrained_sim(From,To,Dist,Count) -> mdl
#' mdl %>% dest_coefs
#' @export
dest_coefs <- function(sim_obj) {
  tp <- attr(sim_obj,"type")
  sim_obj$data$dest%>%unique -> dest_names
  if (tp %in% c("dest","dbl")) {
    coef_choice <- grepl("^dest",names(coef(sim_obj)))
    coefs <- coef(sim_obj)[coef_choice]
    names(coefs) <- sub("dest","",names(coefs))
    extra <- 0
    names(extra) <- dest_names[!dest_names %in% names(coefs)]
    coefs <- c(extra,coefs)
    return(tibble(dest=names(coefs),dest_coef=exp(coefs)))
  }
  if (tp == "orig") {
    coef_choice <- attr(sim_obj,"at")
    coefs <- coef(sim_obj)[coef_choice]
    return(tibble(dest_var=names(coefs),dest_coef=exp(coefs)))
  }
  coef_choice <- attr(sim_obj,"prat")$dest
  coefs <- coef(sim_obj)[coef_choice]
  return(tibble(dest_var=names(coefs),dest_coef=exp(coefs)))
}

#' Extract SIM model scores relating to destination
#'
#' @param sim_obj A 'sim' object
#' @return A tibble with a list of attractiveness scores - either based on balancing terms for
#' each area,  or on the basis of the attractiveness variables,  depending on whether destination constraints
#' were used.
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% orig_constrained_sim(From,To,eastmid_empl,Dist,Count) -> mdl
#' mdl %>% dest_scores
#' @export
dest_scores <- function(sim_obj) {
  tp <- attr(sim_obj,"type")
  sim_obj$data$dest%>%unique -> dest_names
  if (tp %in% c("dest","dbl")) {
    coef_choice <- grepl("^dest",names(coef(sim_obj)))
    coefs <- coef(sim_obj)[coef_choice]
    names(coefs) <- sub("dest","",names(coefs))
    extra <- 0
    names(extra) <- dest_names[!dest_names %in% names(coefs)]
    coefs <- c(extra,coefs)
    return(tibble(dest=names(coefs),dest_score=exp(coefs)))
  }
  if (tp == "orig") {
    coef_choice <- attr(sim_obj,"at")
    coefs <- coef(sim_obj)[coef_choice]
    sim_obj$data %>% group_by(dest) %>% summarise_all(first) -> tdf
    ds <- as.numeric(as.matrix(tdf[,coef_choice]) %*% coefs)
    return(tibble(dest=tdf$dest,dest_score=exp(ds)))
  }
  coef_choice <- attr(sim_obj,"prat")$dest
  coefs <- coef(sim_obj)[coef_choice]
  sim_obj$data %>% group_by(dest) %>% summarise_all(first) -> tdf
  ds <- as.numeric(as.matrix(tdf[,coef_choice]) %*% coefs)
  return(tibble(dest=tdf$dest,dest_score=exp(ds)))
}
