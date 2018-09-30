
# indialights

Tools to Work with the ‘India Lights’ ‘API’

## Description

The ‘India Lights’ ‘API’ shows light output at night for 20 years, from
1993 to 2013, for 600,000 villages across India. The ‘Defense
Meteorological Satellite Program’ (‘DMSP’), run by the ‘U.S.’
‘Department of Defense’, has taken pictures of the Earth every night
for 20 years. Researchers at the ‘University of Michigan’ used the
‘DMSP’ images to extract the data and provide it in tabular form.
The ‘India Lights’ ‘API’ provides the data at convenient endpoints that
allows you to look at specific time intervals and administration levels.
Tools are provided to query these ‘API’ endpoints.

## What’s Inside The Tin

The following functions are implemented:

  - `ial_district`: Time series for a single district
  - `ial_districts`: Time series for all districts in a state
  - `ial_regions`: List of all the regions (districts) with display name
    and id
  - `ial_state`: Time series for a single state
  - `ial_states`: Time series for all states in the nation
  - `ial_villages`: Time series for comma separated list of villages

## Installation

``` r
devtools::install_git("https://gitlab.com/hrbrmstr/indialights.git")
```

## Usage

``` r
library(indialights)
library(tidyverse)

# current verison
packageVersion("indialights")
```

    ## [1] '0.1.0'

### The examples from <http://api.nightlights.io/>

Time series for a single district:

``` r
ial_district("gujarat-anand", "1993.3", "1993.4")
```

    ## # A tibble: 2 x 10
    ##   key            year month satellite count vis_median quintile1 quintile2 quintile3 quintile4
    ## * <chr>         <int> <int> <chr>     <int> <chr>      <chr>     <chr>     <chr>     <chr>    
    ## 1 gujarat-anand  1993     3 F10        6619 0.6481     -2.1790   -0.2632   1.7368    4.5750   
    ## 2 gujarat-anand  1993     4 F10        6497 1.0545     -4.7625   -0.2222   2.2115    4.9867

Time series for all districts in a state:

``` r
ial_state(
  state_id = "gujarat", 
  interval_start = "1993.3", 
  interval_stop = "1993.4"
)
```

    ## # A tibble: 2 x 6
    ##   key      year month satellite  count vis_median
    ## * <chr>   <int> <int> <chr>      <int> <chr>     
    ## 1 gujarat  1993     3 F10       377081 -0.7027   
    ## 2 gujarat  1993     4 F10       345442 -0.1569

List of all the regions (districts) with display name and id:

**NOTE THIS ENDPOINT ON THEIR SERVER IS BROKEN**

``` r
ial_regions()
```

    ## Error in ial_regions(): Not Found (HTTP 404).

Time series for all states in the nation:

``` r
ial_states(
  interval_start = "1993-03-01",
  interval_stop = "1993-04-01"
)
```

    ## # A tibble: 56 x 6
    ##    key               year month satellite  count vis_median
    ##  * <chr>            <int> <int> <chr>      <int> <chr>     
    ##  1 gujarat           1993     3 F10       377081 -0.7027   
    ##  2 nagaland          1993     3 F10        25885 -2.1263   
    ##  3 manipur           1993     3 F10        39768 -2.1789   
    ##  4 himachal-pradesh  1993     3 F10       254726 -2.0625   
    ##  5 haryana           1993     3 F10       110908 0.4189    
    ##  6 maharashtra       1993     3 F10       801457 -0.5811   
    ##  7 tripura           1993     3 F10        15390 -1.5789   
    ##  8 madhya-pradesh    1993     3 F10       965823 -1.4444   
    ##  9 andhra-pradesh    1993     3 F10       548725 -0.6000   
    ## 10 west-bengal       1993     3 F10       738797 -1.4615   
    ## # ... with 46 more rows

Time series for the given state:

``` r
ial_state(
  state_id = "gujarat",
  interval_start = as.Date("1993-03-01"),
  interval_stop = as.Date("1993-04-01")
)
```

    ## # A tibble: 2 x 6
    ##   key      year month satellite  count vis_median
    ## * <chr>   <int> <int> <chr>      <int> <chr>     
    ## 1 gujarat  1993     3 F10       377081 -0.7027   
    ## 2 gujarat  1993     4 F10       345442 -0.1569

Time series for comma separated list of villages:

``` r
ial_villages(
  village_ids = c("104000100132900", "104000200153500", "108000200308200"),
  interval_start = "1993.3", 
  interval_stop = "1993.4"
)
```

    ## # A tibble: 6 x 10
    ##   villagecode      year month satellite count vis_mean vis_sd vis_min vis_median vis_max
    ## * <chr>           <int> <int> <chr>     <int> <chr>    <chr>  <chr>   <chr>      <chr>  
    ## 1 104000100132900  1993     3 F10          14 -1.1331  2.8296 -4.1263 -1.9428    6.3824 
    ## 2 104000200153500  1993     3 F10          16 -0.7159  2.1901 -3.9485 -0.2419    2.9882 
    ## 3 108000200308200  1993     3 F10          16 4.8919   6.2519 -3.7027 1.9200     18.3176
    ## 4 104000100132900  1993     4 F10           4 -3.4463  1.3440 -5.0460 -3.4837    -1.7719
    ## 5 104000200153500  1993     4 F10           4 -2.1963  4.9374 -7.0460 -2.4837    3.2281 
    ## 6 108000200308200  1993     4 F10           5 12.1391  7.3060 0.4717  12.6806    20.3521

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
