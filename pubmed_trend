##' query pubmed record numbers of search term through years
##'
##' 
##' @title pubmed_trend
##' @param searchTerm search term
##' @param year year vector 
##' @return data.frame
##' @author ygc
##' @importFrom plyr ldply
##' @export
##' @examples
##' pubmed_trend("Yu Guangchuang[Full Author Name]", 2010:2016)

install.packages("RISmed")
library(RISmed)
pubmed_trend <- function(searchTerm, year) {
    if (length(searchTerm) == 1)
        return(pubmed_trend.internal(searchTerm, year))
    res <- lapply(searchTerm, pubmed_trend.internal, year=year)
    names(res) <- searchTerm
    res.df <- ldply(res)
    colnames(res.df)[1] <- "TERM"
    return(res.df)
}

##' @importFrom RISmed EUtilsSummary
##' @importFrom RISmed QueryCount
pubmed_trend.internal <- function(searchTerm, year) {
    num <- array()
    x <- 1
    for (i in year){
        Sys.sleep(1)
        cat("querying year ", i, "\n")
        r <- EUtilsSummary(searchTerm, type='esearch', db='pubmed', mindate=i, maxdate=i)
        num[x] <- QueryCount(r)
        x <- x + 1
    }
    res <- data.frame(year=year, number=num)
    return(res)
}


