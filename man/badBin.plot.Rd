% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/badBin.plot.R
\name{badBin.plot}
\alias{badBin.plot}
\title{Print RCP_base versus RCP-test}
\usage{
badBin.plot(hicMat, res, bin, RCP_base = RCP_base)
}
\arguments{
\item{hicMat}{The Hi-C Ice-data.table}

\item{res}{The resolution}

\item{bin}{The bin to plot}
}
\value{
A list containing a vector with the bad bin-id's (`badBins`). Optionally, it can output a bed-file (`bed`).
}
\description{
Used witin badBin.find
}
