% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quantifyAPA.R
\name{quantifyAPA}
\alias{quantifyAPA}
\title{Get statistics from the centers of APA-results}
\usage{
quantifyAPA(APAlist, enrichment = F, pixWidth = 3, speudoCount = 1,
  enrichmentType = "medianScore")
}
\arguments{
\item{APAlist}{A named list of outputs from APA().}

\item{enrichment}{Calculate log2-enrichment instead of contacts?}

\item{pixWidth}{The width of the square to use. 1 will give you just the
center-point}

\item{enrichmentType}{meanScore gives the pixel/mean(backgroundRegions) score.
medianBool gives the fraction of background-regions less
than 50 percent of the pixel (1 = a true loop).}
}
\value{
Alist of two dataframes: data (per-loop and -sample average scores)
and stats (all-vs-all wilcoxon.test p-values and log2-foldchanges.)
}
\description{
Takes the input from APA() and produces a list of average centers and
comparitory statistics, where centers is a square region of
pixWidth x pixWidth in the middle.
}
\examples{
# run APA() on sample(s)
APA_WT <- APA(experiment = WT, loop.bed = loopsWT)
APA_WA <- APA(experiment = WA, loop.bed = loopsWT)

# run quantifyAPA()
APAstats <- quantifyAPA(list("WT" = APA_WT, "MED12" = APA_MD), pixWidth = 3)

# get the statistics
APAstats$stats

# plot boxplots
ggplot(APAstats$data, aes(x = sample, y = value)) +
  geom_boxplot()
}
