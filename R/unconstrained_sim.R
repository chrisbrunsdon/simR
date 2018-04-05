#' Calibrate an unconstrained spatial interaction model (SIM) via a Poisson regression.
#'
#' @param df A tibble or a data frame.
#' @param orig A column reference - the origin (a character or factor)
#' @param dest A column reference - the destination (a character or factor)
#' @param attr A data frame (or tibble) of destination attraction variables
#' @param prod A data frame (or tibble) of origin production variables
#' @param cost A column reference - the cost (for example, a distance, financial cost or travel time)
#' @param intr A column reference - the interaction count
#' @param type What type of model to use (unconstr, orig, dest, dbl)
#' @return A 'sim' object - like a model object but with a few extra attributes.
#' @export
#' @import tidyverse
#' @import sf
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% unconstrained_sim(From,To,Dist,Count)
unconstrained_sim <- function(df,orig,dest,attr,prod,cost,intr) {
  orig <- enquo(orig)
  dest <- enquo(dest)
  cost <- enquo(cost)
  intr <- enquo(intr)
  df %>% transmute(orig = !!orig, dest = !!dest, cost = !!cost, intr = !!intr) -> dfs
  attr %>% mutate(dest = !!dest) %>% select(-!!dest) -> attrs
  dfs %>% left_join(attrs) -> dfs
  prod %>% mutate(orig = !!orig) %>% select(-!!orig) -> prods
  dfs %>% left_join(prods) -> dfs
  form <- formula(paste("intr ~",paste(setdiff(colnames(dfs),c("intr","dest","orig")),collapse="+")))
  mdl <- glm(form,data=dfs,family=poisson())
  attr(mdl,"type") <- "ucst"
  attr(mdl,"vars") <- c(orig=orig,dest=dest,cost=cost,intr=intr)
  attr(mdl,"prat") <- list(orig=setdiff(colnames(prods),"orig"),dest=setdiff(colnames(attrs),"dest"))
  class(mdl) <- c("sim",class(mdl))
  return(mdl)
}


