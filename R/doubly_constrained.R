#' Calibrate an doubly-constrained spatial interaction model (SIM) via a Poisson regression.
#'
#' @param df A tibble or a data frame.
#' @param orig A column reference - the origin (a character or factor)
#' @param dest A column reference - the destination (a character or factor)
#' @param cost A column reference - the cost (a character or factor)
#' @param intr A column reference - the interaction count (a character or factor)
#' @return A 'sim' object - like a model object but with a few extra attributes.
#' @export
#' @import tidyverse
#' @import sf
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% doubly_constrained_sim(From,To,Dist,Count)
doubly_constrained_sim <- function(df,orig,dest,cost,intr) {
  orig <- enquo(orig)
  dest <- enquo(dest)
  cost <- enquo(cost)
  intr <- enquo(intr)
  df %>% transmute(orig = !!orig, dest = !!dest, cost = !!cost, intr = !!intr) -> dfs
  form <- formula(paste("intr ~",paste(setdiff(colnames(dfs),c("intr")),collapse="+")))
  mdl <- glm(form,data=dfs,family=poisson())
  attr(mdl,"type") <- "dbl"
  attr(mdl,"vars") <- c(orig=orig,dest=dest,cost=cost,intr=intr)
  attr(mdl,"prat") <- NULL
  class(mdl) <- c("sim",class(mdl))
  return(mdl)
}


