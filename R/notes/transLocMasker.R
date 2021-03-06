# zvf10_findTranslocs
# Functs

plotRCP_SpecificBin <- function(hicMat, res, bin, RCP_base = RCP_base){
  binStop <- (1e6 / res) + bin
  x <- rep(bin, (1e6 / res))
  y <- seq(bin,binStop-1)
  vals <- hicMat[list(x,y)]
  vals[is.na(vals$V3)]$V3   <- 0
  plot(RCP_base , col = 'blue', type='l', xlab = "RCP_test", ylab = 'RCP', main = paste0("Results for bin ",bin))
  lines(vals$V3, col = 'red')
}

find.badBins <- function(experiment, p.treshold, plotBad = T, getBed = T){
  ## INIT-phase
  cat("Initiation...\n")
  allbins <- unique(experiment$ICE$V1)
  maxbin <- max(allbins)
  oneToMaxBin <- 1:maxbin

  res <- experiment$RES
  ### Sample 1000 bins (more, if runtime is low enough)
  sampledBINs <- sample(unique(experiment$ICE$V1), size = 1000)

  cat("Generating base RCP... 0 percent\t\t\t\t\r\r")
  ### Make mean RCP of sampled bins -> RCP_base
  RCP_base <- rep(0, (1e6 / res)/2)
  for(i in 1:length(sampledBINs)){
    if(i%% 10 == 0){
      cat("Generating base RCP...", round((i/1000)*100, digits = 2), "percent\t\t\t\t\r")
    }
    bin <- sampledBINs[i]
    binStop <- (1e6 / res)/2 + bin
    x <- rep(bin, (1e6 / res)/2)
    y <- seq(bin,binStop-1)
    vals <- experiment$ICE[list(x,y)]
    vals[is.na(vals$V3)]$V3   <- 0
    ### Make sum RCP of sampled bins -> RCP_base
    RCP_base <- RCP_base + vals$V3
  }
  RCP_base <- RCP_base / 1000
  RCP_base.model <- lm(log(c(1:50))~ RCP_base)
  #
  cat("\n")
  cat("Iterating over matrix... 0 percent\r")
  COR.list <- list()
  for(I in oneToMaxBin){
    if(I%% 1000 == 0){
      cat("Iterating over matrix...", round((I/maxbin)*100, digits = 2), "percent\t\t\r")
    }
    bin <- I
    binStop <- (1e6 / res)/2 + bin
    x <- rep(bin, (1e6 / res)/2)
    y <- seq(bin,binStop-1)
    vals <- experiment$ICE[list(x,y)] # maybe also the other way around?
    if( sum(is.na(vals$V3)) > 49){# saves time: no need to do cor-test on NA's
      COR.list[[I]] <- c(bin, 0, 1)
    } else{
      for (i in seq_along(vals)) data.table::set(vals, i=which(is.na(vals[[i]])), j=i, value=0)
      exponential.model <- lm(log(c(1:50))~ vals$V3)
      b <- cor.test(fitted.values(exponential.model), fitted.values(RCP_base.model))
      COR.list[[I]] <- c(bin, b$estimate, b$p.value)
    }
  }
  COR_df <- data.frame(abs(matrix(unlist(COR.list), ncol = 3, byrow = T)))
  COR_df.ordered <- COR_df[order(COR_df$X3),]
  badBins <- COR_df.ordered[COR_df.ordered$X3 > p.treshold,1]
  # This doesn't store it...
  #experiment$MASK <- c(experiment$MASK,badBins)
  if(plotBad){
    par(mfrow = c(4,5))
    toPlot <- sample(badBins, size = 20)
    for(i in 1:20){
      plotRCP_SpecificBin(hicMat  = experiment$ICE, res = res, RCP_base = RCP_base, bin = toPlot[i])
    }
  }
  if(getBed){
    bed <- data.frame(seqnames = character(),
                      start = numeric(),
                      stop = numeric())
    for(j in badBins){
      bed <- rbind(bed, experiment$ABS[j,c(1,2,3)])
    }
    return(list(badBins = badBins, bed = bed))
  } else {
    return(list(badBins = badBins))
  }

}
