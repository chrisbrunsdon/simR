#' Add a column with the predicted data from a model
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
add_sim_fitted <- function(df,sim_obj,colname,newdata=NULL) {
  if(missing(colname)) {
    fitvar <- predict(sim_obj,type='response',newdata=newdata)
    return(df %>% mutate(Fitted=fitvar))
  } else {
    colname <- quo_name(enquo(colname))
    fitvar <- predict(sim_obj,type='response',newdata=newdata)
    return(df %>% mutate(!!colname := fitvar))
  }
}
