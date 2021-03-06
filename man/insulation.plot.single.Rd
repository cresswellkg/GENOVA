% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/insulation_score.R
\name{insulation.plot.single}
\alias{insulation.plot.single}
\title{plot.insulation.single}
\usage{
insulation.plot.single(exp1, chrom, start, end, cut.off = NULL,
  window.size = 21, local = T)
}
\arguments{
\item{exp1}{The Hi-C experiment object: produced by construct.experiment().}

\item{chrom}{Chromosome}

\item{start}{Start position of the region of interest}

\item{end}{End position of the region of interest}

\item{cut.off}{The cut.off for Hi-C scores}

\item{window.size}{The sliding square size}

\item{Local}{or per-chromosome normalisation?}
}
\value{
A plot
}
\description{
Plot a single insulation-score and Hi-C matrix for a region of interest.
}
\examples{
# Make a matrix-plot of an experiment and the insulation-score for a region of interest.
}
