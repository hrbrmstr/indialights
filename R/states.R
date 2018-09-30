#' Time series for all states in the nation
#'
#' @md
#' @param interval_start,interval_end start/end dates for itervals. They can
#'        be `Date` objects (only the year and month will be used in the API
#'        call) or strings. If strings, they can be full ISO date strings
#'        (i.e. "2018-09-29") or strings in the `yy.mm` format the API
#'        described. They will be handled automagically for you but the
#'        function assumes that `interval_start` and `interval_end` both
#'        have the same format string or are both `Date` objects.
#' @return data frame
#' @export
ial_states <- function(interval_start, interval_stop) {

  if (inherits(interval_start, "Date")) {
    interval_start <- format(interval_start, "%Y.%m")
    interval_stop <- format(interval_stop, "%Y.%m")
  } else if (is.character(interval_start)) {
    if (nchar(interval_start) == 10) {
      interval_start <- format(as.Date(interval_start), "%Y.%m")
      interval_stop <- format(as.Date(interval_stop), "%Y.%m")
    }
  }

  interval <- sprintf("%s.%s", interval_start, interval_stop)

  url_template <- "http://api.nightlights.io/months/%s-%s/states"

  httr::GET(
    url = sprintf(url_template, interval_start, interval_stop),
    httr::user_agent("indialights R package / <gitlab/hrbrmstr/indialights>")
  ) -> res

  httr::stop_for_status(res)

  xdat <- httr::content(res, as="text")
  xdat <- jsonlite::fromJSON(xdat)

  class(xdat) <- c("tbl_df", "tbl", "data.frame")

  xdat

}
