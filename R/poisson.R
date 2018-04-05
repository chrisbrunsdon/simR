#' Carry out a Poisson regression.
#'
#' @param df A tibble or a data frame.
#' @param orig A column reference - the origin (a character or factor)
#' @param dest A column reference - the destination (a character or factor)
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
poisson_reg <- function(df,orig,dest,cost,intr,type='dbl') {
  orig <- enquo(orig)
  dest <- enquo(dest)
  cost <- enquo(cost)
  intr <- enquo(intr)
  df %>% transmute(orig = !!orig, dest = !!dest, cost = !!cost, intr = !!intr) -> dfs
  mdl <- switch(type,
                unconstr = glm(intr~cost,          data=dfs,family=poisson()),
                orig     = glm(intr~cost+orig,     data=dfs,family=poisson()),
                dest     = glm(intr~cost+dest,     data=dfs,family=poisson()),
                dbl      = glm(intr~cost+dest+orig,data=dfs,family=poisson()))
  attr(mdl,"type") <- type
  attr(mdl,"vars") <- c(orig=orig,dest=dest,cost=cost,intr=intr)
  class(mdl) <- c("sim",class(mdl))
  return(mdl)
}


