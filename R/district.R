#' Time series for a single district
#'
#' @md
#' @param district_id a length 1 character vector with a single district ID
#' @param interval_start,interval_end start/end dates for itervals. They can
#'        be `Date` objects (only the year and month will be used in the API
#'        call) or strings. If strings, they can be full ISO date strings
#'        (i.e. "2018-09-29") or strings in the `yy.mm` format the API
#'        described. They will be handled automagically for you but the
#'        function assumes that `interval_start` and `interval_end` both
#'        have the same format string or are both `Date` objects.
#' @return data frame
#' @export
ial_district <- function(district_id, interval_start, interval_stop) {


  interval <- sprintf("%s.%s", interval_start, interval_stop)

  url_template <- "http://api.nightlights.io/months/%s-%s/districts/%s"

  httr::GET(
    url = sprintf(url_template, interval_start, interval_stop, district_id),
    httr::user_agent("indialights R package / <gitlab/hrbrmstr/indialights>")
  ) -> res

  httr::stop_for_status(res)

  xdat <- httr::content(res, as="text")
  xdat <- jsonlite::fromJSON(xdat)

  class(xdat) <- c("tbl_df", "tbl", "data.frame")

  xdat

}
