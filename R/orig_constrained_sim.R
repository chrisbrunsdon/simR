#' Calibrate an origin-constrained spatial interaction model (SIM) via a Poisson regression.
#'
#' @param df A tibble or a data frame.
#' @param orig A column reference - the origin (a character or factor)
#' @param dest A column reference - the destination (a character or factor)
#' @param attr A data frame (or tibble) of destination attraction variables
#' @param cost A column reference - the cost (a character or factor)
#' @param intr A column reference - the interaction count (a character or factor)
#' @param type What type of model to use (unconstr, orig, dest, dbl)
#' @return A 'sim' object - like a model object but with a few extra attributes.
#' @export
#' @import tidyverse
#' @import sf
#' @examples
#' require(tidyverse)
#' eastmid_ttw %>% poisson_reg(From,To,Dist,Count)
orig_constrained_sim <- function(df,orig,dest,attr,cost,intr) {
  orig <- enquo(orig)
  dest <- enquo(dest)
  cost <- enquo(cost)
  intr <- enquo(intr)
  df %>% transmute(orig = !!orig, dest = !!dest, cost = !!cost, intr = !!intr) -> dfs
  attr %>% mutate(dest = !!dest) %>% select(-!!dest) -> attrs
  dfs %>% left_join(attrs) -> dfs
  form <- formula(paste("intr ~",paste(setdiff(colnames(dfs),c("intr","dest")),collapse="+")))
  mdl <- glm(form,data=dfs,family=poisson())
  attr(mdl,"type") <- "orig"
  attr(mdl,"vars") <- c(orig=orig,dest=dest,cost=cost,intr=intr)
  attr(mdl,"at") <- setdiff(colnames(attr),rlang::quo_text(dest))
  class(mdl) <- c("sim",class(mdl))
  return(mdl)
}


