#' List of all the regions (districts) with display name and id
#'
#' @md
#' @return data frame
#' @note As of 2018-09-30 this is a broken endpoint on their server
#' @export
ial_regions <- function() {

  httr::GET(
    url = "http://api.nightlights.io/regions",
    httr::user_agent("indialights R package / <gitlab/hrbrmstr/indialights>")
  ) -> res

  httr::stop_for_status(res)

  xdat <- httr::content(res, as="text")
  xdat <- jsonlite::fromJSON(xdat)

  class(xdat) <- c("tbl_df", "tbl", "data.frame")

  xdat

}
