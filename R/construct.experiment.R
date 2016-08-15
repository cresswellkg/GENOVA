#' Construct a HiC-experiment.
#'
#' Make a structure which holds the most needed information of a HiC-experiment.
#'
#' @param ICEDpath Full path to HiC-pro matrix-file.
#' @param BEDpath Full path the HiC-pro index-file
#' @param SAMPLENAME The name of the sample.
#' @param COLOR Color associated with sample.
#' @param COMMENTS A place to store some comments.
#' @return A list.
#' @export
construct.experiment <- function(ICEDpath,BEDpath, SAMPLENAME, COLOR = 1, COMMENTS = NULL){
  # Check if files exist
  if(!file.exists(ICEDpath)){stop('ICE-matrix file not found.')}
  if(!file.exists(BEDpath)){stop('ICE-index file not found.')}

  ICE <- read.hicpro.matrix(ICEDpath)
  ABS <- read.delim(BEDpath, header = F)
  chromVector <- as.character(unique(ABS$V1))
  a <- dplyr::mutate(ABS, dif = V3-V2)
  b <- dplyr::group_by(a, dif)
  c <- dplyr::summarise(b, nd = n())
  d <- dplyr::filter(c,nd == max(nd))
  e <- dplyr::select(d,dif)
  res = as.numeric(e)

  # Contruct list
  list(
    # Iced HiC-matrix in three-column format (i.e. from HiC-pro)
    ICE = ICE,

    # HiC-index in four-column format (i.e. from HiC-pro)
    ABS = ABS,

    # Name of sample
    NAME = SAMPLENAME,

    # Resolution of sample
    RES = res,

    # Available chromosomes
    CHRS = chromVector,

    # Color of sample (optional, but recommended for running RCP)
    COL = COLOR,

    # Comments
    COMM = COMMENTS

  )
}