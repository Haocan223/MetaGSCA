## ----setup, include=FALSE, echo=FALSE, warning=FALSE-------------------------------------------------------------
library(knitr)


## ----loadLibrary-------------------------------------------------------------------------------------------------
library(MetaGSCA)


## ----setWorkdir--------------------------------------------------------------------------------------------------
## set your workdir
if (!exists('tutorial')) dir.create('tutorial')
setwd('tutorial')


## ----loadData, warning =FALSE------------------------------------------------------------------------------------
###########################
data(meta)
datasets <- vector('list',length(Dsetnames))
names(datasets) <- Dsetnames
for (ca in Dsetnames) {
  cmd=paste0('data(',ca,')')
  eval(parse(text=cmd))
  cmd=paste0(ca,'<-data.frame(V1=rownames(',ca,'),',ca,')') # Create first col to meet MetaGSCA requirement.
  eval(parse(text=cmd))
  cmd=paste0('datasets[[ca]] <- ',ca)
  eval(parse(text=cmd))
}
datasetnames <- Dsetnames
genesetnames <- names(genesets)


## ----showGenesetNames, echo=FALSE--------------------------------------------------------------------------------
genesetnames


## ----showDatasetDims, echo=FALSE---------------------------------------------------------------------------------
tmp <- sapply(datasets,dim) 
rownames(tmp) <- c('#Genes','#Samples')
tmp


## ----testSingle,warning=FALSE------------------------------------------------------------------------------------
testSingle <- MetaGSCA(list.geneset = genesets[[2]],
         list.dataset = datasets,
         list.group = groups,
         name.geneset = genesetnames[[2]],
         name.dataset = datasetnames,
         nperm = 100,
         nboot = 100,
         method.Inverse = FALSE,
         method.GLMM = TRUE,
         fixed.effect = FALSE,
         random.effect = TRUE)


## ----recapSingleParams-------------------------------------------------------------------------------------------
genesetnames[2]
genesets[2]


## ----listSingleOutFiles, echo=FALSE------------------------------------------------------------------------------
dir(pattern=genesetnames[[2]])


## ----showSingleFig,echo=FALSE, out.width = "90%", fig.align='center', dpi=200, fig.cap="Forest plot for one gene set across multiple datasets"----
#result1 <- paste(system.file("extdata", package = "MetaGSCA"), "/Aminosugars metabolism_GLMM_Meta Analysis for bootstrap p-value_Forest plot.png", sep="")
result1 <- grep('pdf',dir(pattern=genesetnames[[2]]),value=T)
knitr::include_graphics(result1)


## ----showSingleCsv,echo=FALSE------------------------------------------------------------------------------------
#result2 <- paste(system.file("extdata", package = "MetaGSCA"), "/Aminosugars metabolism_Individual Dataset GSAR Results with Bootstrapping.csv", sep="")
result2 <- grep('csv',dir(pattern=genesetnames[[2]]),value=T)
t(read.csv(result2))[,1:2]


## ----testMultiple, warning=FALSE, eval=FALSE---------------------------------------------------------------------
## testMultiple <- MetaGSCA_Multi_Geneset(list.geneset = genesets[1:2],
##                        list.dataset = datasets,
##                        list.group = groups,
##                        name.geneset = genesetnames[1:2],
##                        name.dataset = datasetnames,
##                        nperm = 100,
##                        nboot = 100,
##                        method.Inverse = FALSE,
##                        method.GLMM = TRUE,
##                        fixed.effect = FALSE,
##                        random.effect = TRUE)


## ----------------------------------------------------------------------------------------------------------------
genesetnames[1:2]
genesets[1:2]


## ----listMultiOutFiles,echo=FALSE--------------------------------------------------------------------------------
sort(dir(pattern='csv|pdf'))
#result <- paste(system.file("extdata", package = "MetaGSCA"), "/multiple.png", sep="")
#knitr::include_graphics(result)


## ----showMultiFig1, echo=FALSE, out.width = "90%", fig.align='center', dpi=200, fig.cap="Forest plot for one gene set across multiple datasets"----
#result1 <- paste(system.file("extdata", package = "MetaGSCA"), "/Aminosugars metabolism_GLMM_Meta Analysis for bootstrap p-value_Forest plot.png", sep="")
result1 <- grep('pdf',dir(pattern=genesetnames[[1]]),value=T)
knitr::include_graphics(result1)



## ----showMultiFig2,echo=FALSE, out.width = "90%", fig.align='center', dpi=200, fig.cap="Forest plot for another gene set across multiple datasets"----
#result1 <- paste(system.file("extdata", package = "MetaGSCA"), "/Arginine and Proline metabolism_GLMM_Meta Analysis for bootstrap p-value_Forest plot.png", sep="")
result1 <- grep('pdf',dir(pattern=genesetnames[[2]]),value=T)
knitr::include_graphics(result1)


## ----showMultiCsv1,echo=FALSE------------------------------------------------------------------------------------
result2 <- grep('csv',dir(pattern=genesetnames[[1]]),value=T)
t(read.csv(result2))[,1:2]


## ----showMultiCsv2, echo=FALSE-----------------------------------------------------------------------------------
result2 <- grep('csv',dir(pattern=genesetnames[[2]]),value=T)
t(read.csv(result2))[,1:2]


## ----demoPWcTalk,warning=FALSE, eval=FALSE-----------------------------------------------------------------------
## data(input2PWcTalk)
## ## step 4.1, one code line to execute pathway crosstalk analysis. Simple, but no flexibility for layout tuning.
## PWcTalk(input2PWcTalk,test='binary',
##   pTh.dataset=0.01,pTh.pwPair=0.01,pTh.pw=0.01,figname='PWcTalk',
##   pdfW=10,pdfH=10,asp=0.7,vbase=15,ebase=2,vlbase=1,power=1/2)
## ## step 4.2, one code block to execute pathway crosstalk analysis. More code lines, but enabling interactive layout tuning.
## preNW <- PWcTalkNWpre(input2PWcTalk,test='binary',
##   pTh.dataset=0.01,pTh.pwPair=0.01,pTh.pw=0.01)
## g_tkid <- PWcTalkNW(preNW$PW.pair,preNW$PW.p)
## ##### PAUSE here: adjust the network layout on the pop-out window to reach a satisfaction #####
## coords <- tk_coords(g_tkid$tkid)
## g_tkid <- PWcTalkNW(preNW$PW.pair,preNW$PW.p,layout=coords,pdfW=14,pdfH=10,figname='PWcTalk',asp=0.5)
## 

## ----showPWcTalkFig,echo=FALSE, out.width = "90%", fig.align='center', dpi=200, fig.cap="A demonstration pathway crosstalk network"----
result1 <- paste(system.file("extdata", package = "MetaGSCA"), "/PWcTalk.png", sep="")
knitr::include_graphics(result1)

