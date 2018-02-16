## ----global_options, include=FALSE-----------------------------------------
knitr::opts_chunk$set(fig.pos = 'h')

## ----echo = F--------------------------------------------------------------
color.bar <- function(lut, min, max=-min, nticks=11, ticks=seq(min, max, len=nticks), title='') {
    scale = (length(lut)-1)/(max-min)

    #dev.new(width=1.75, height=5)
    plot(c(0,10), c(min,max), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main=title)
    axis(4, ticks, las=1)
    for (i in 1:(length(lut)-1)) {
     y = (i-1)/scale + min
     rect(1.5,y,10,y+1/scale, col=lut[i], border=NA)
    }
}

## ----echo=FALSE, out.width='100%', fig.align='center'----------------------
knitr::include_graphics('/DATA/users/r.vd.weide/github/GENOVA/t1logo')

## ---- echo=T, warning=FALSE, error=F, results='hide'-----------------------
# devtools::install_github("robinweide/GENOVA", ref = 'dev')
library(GENOVA)

## ----peakEXP3, collapse=F, results='markup', echo = F----------------------
str(Hap1_WT_40kb, width = 60,   vec.len=1, strict.width = 'wrap')

## ----J2G, eval=FALSE, highlight=FALSE--------------------------------------
#  # Convert data from Sanborn et al. normalised at 10kb resoltion:
#  juicerToGenova.py -C ucsc.hg19_onlyRealChromosomes.noChr.chromSizes \
#  -JT ~/bin/juicer/AWS/scripts/juicebox_tools.7.0.jar \
#  -H ~/Downloads/Sanborn_Hap1_combined_30.hic \
#  -R 10000 \
#  -force TRUE \
#  -norm KR \
#  -O Sanborn_Hap1_combined_30.hic_10kb_KR

## ----cis, cache=T,fig.cap="Fraction of cis-contacts per chromosome.", fig.small = T----
cisChrom_out <- cisTotal.perChrom( Hap1_WT_1MB )

## ----cis2, cache=T,fig.cap="Fraction of cis-contacts per chromosome. Chromosomes 9, 15, 19 \\& 22 have translocations, which therefore appear to have more trans-contacts, but which in reality are cis-contacts.", fig.small = T----
plot( cisChrom_out$perChrom, las=2 )
abline( h = cisChrom_out$genomeWide, col = 'red' ) 

## ---- echo=F---------------------------------------------------------------
options(scipen = 1)

## ---- echo =F--------------------------------------------------------------
knitr::kable(
  head(CTCF, 3), caption = 'A data.frame holding a standard BED6 format.'
)

## ----bigwrig, eval=F, echo = F---------------------------------------------
#  library(devtools)
#  install_github(repo ='bigwrig', username =  'jayhesselberth')

## ---- echo =F--------------------------------------------------------------
knitr::kable(
  head(martExport[,-c(1,2)], 5), caption = 'A data.frame holding the needed columns for plotting genes.'
)

## ---- echo=F---------------------------------------------------------------
options(scipen = 1e9)

## ---- echo=F---------------------------------------------------------------
options(scipen = 1)

## ----sesh, echo = F--------------------------------------------------------
sessionInfo()
