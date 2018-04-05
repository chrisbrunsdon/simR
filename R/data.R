#' East Midlands travel-to-work data
#'
#' A dataset contain ing travel-to-work counts for
#' local authority (LA) areas in the East Midlands (UK) taken
#' from the 2011 Census.
#'
#' Contains National Statistics data © Crown copyright and database right [2018]
#'
#'
#' @format A data frame with 1600 rows and 4 variables:
#' \describe{
#'   \item{To}{Name of origin LA of trip to work}
#'   \item{From}{Name of destination LA of trip to work}
#'   \item{Dist}{Distance from origin to destimation (Crow flies)}
#'   \item{Count}{Number of people taking the \code{To} to \code{From} trip to work  }
#' }
#' @source \url{https://www.nomisweb.co.uk/query/construct/summary.asp?mode=construct&version=0&dataset=1211}
"eastmid_ttw"

#' East Midlands employer data - enterprises
#'
#' A dataset containing counts of employers for
#' local authority (LA) areas in the East Midlands (UK) taken
#' from the Inter Departmental Business Register (IDBR)
#'
#' Contains National Statistics data © Crown copyright and database right [2018]
#'
#'
#' @format A data frame with 40 rows and 5 variables:
#' \describe{
#'   \item{To}{Name of destimation LA of trip to work}
#'   \item{Micro}{Count of Micro enterprises (0 to 9)}
#'   \item{Small}{Count of Small enterprises (10 to 49)}
#'   \item{Medium}{Count of Medium enterprises (50 to 249)}
#'   \item{Large}{Count of Large enterprises (250+)}
#' }
#' @source \url{https://www.nomisweb.co.uk/query/construct/summary.asp?mode=construct&version=0&dataset=142}
"eastmid_empl"

#' East Midlands employer data - enterprises
#'
#' A dataset containing counts of economically active residents for
#' local authority (LA) areas in the East Midlands (UK) taken
#' from the 2011 UK Census
#'
#' Contains National Statistics data © Crown copyright and database right [2018]
#'
#'
#' @format A data frame with 40 rows and 2 variables:
#' \describe{
#'   \item{From}{Name of origin LA of trip to work}
#'   \item{EcAct}{Count of economically active residents}
#' }
#' @source \url{https://www.nomisweb.co.uk/query/construct/summary.asp?mode=construct&version=0&dataset=556}
"eastmid_ec_act"


#' East Midlands 'simple features' polygon object
#'
#' An \code{sf} polygon data frame containing boundaries for
#' local authority (LA) areas in the East Midlands (UK).  A line
#' simplification algorithm (due to Visvalingham) maintaining
#' topological integrity has been applied.
#'
#' Contains National Statistics data © Crown copyright and database right [2018] \cr
#' Contains OS data © Crown copyright [and database right] (2018) \cr
#'
#' @references
#' M. Visvalingam and J. D. Whyatt. Line generalisation by repeated elimination of points. The Cartographic Journal, 30(1):46–51, 1993.
#'
#' @format An \code{sf} data frame with 40 rows and 3 variables:
#' \describe{
#'   \item{code}{Code for LA area}
#'   \item{name}{Name of LA area}
#'   \item{geometry}{Geometry column containing boundary shapes}
#' }
#' @source \url{https://www.nomisweb.co.uk/query/construct/summary.asp?mode=construct&version=0&dataset=1211}
"eastmid_sf"