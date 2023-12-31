% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/remprofile.R
\name{remprofile}
\alias{remprofile}
\title{Extract DNA methylation data profiled in RE}
\usage{
remprofile(
  methyDat,
  REtype = c("Alu", "L1", "ERV"),
  annotation.source = c("AH", "UCSC"),
  genome = c("hg19", "hg38"),
  Seq.GR = NULL,
  RE = NULL,
  impute = FALSE,
  imputebyrow = TRUE,
  verbose = FALSE
)
}
\arguments{
\item{methyDat}{A \code{\link{RatioSet}}, \code{\link{GenomicRatioSet}}, \code{\link{DataFrame}},
\code{data.table}, \code{data.frame}, or \code{matrix} of Illumina BeadChip methylation data
(450k or EPIC array) or Illumina methylation percentage estimates by sequencing.}

\item{REtype}{Type of RE. Currently \code{"Alu"}, \code{"L1"}, and \code{"ERV"} are supported.}

\item{annotation.source}{Character parameter. Specify the source of annotation databases, including
the RefSeq Gene annotation database and RepeatMasker annotation database. If \code{"AH"}, the database 
will be obtained from the AnnotationHub package. If \code{"UCSC"}, the database will be downloaded 
from the UCSC website http://hgdownload.cse.ucsc.edu/goldenpath. The corresponding build (\code{"hg19"} or 
\code{"hg38"}) will be specified in the parameter \code{genome}.}

\item{genome}{Character parameter. Specify the build of human genome. Can be either \code{"hg19"} or 
\code{"hg38"}. For 450k/EPIC array, \code{"hg19"} is used more often while specifying \code{"hg38"} will 
lift over the Illumina CpG probe location to build \code{"hg38"}. For sequencing data, please make
sure the specified genome build is consistent with the actual genome build of \code{Seq.GR}.}

\item{Seq.GR}{A \code{\link{GRanges}} object containing genomic locations of the CpGs profiled by sequencing
platforms. This parameter should not be \code{NULL} if the input methylation data \code{methyDat} are
obtained by sequencing. Note that the genomic location can be in either hg19 or hg38 build. The user
should make sure the parameter \code{genome} is correctly specified.}

\item{RE}{A \code{\link{GRanges}} object containing user-specified RE genomic location information.
If \code{NULL}, the function will retrive RepeatMasker RE database from \code{\link{AnnotationHub}}
(build hg19) or download the database from UCSC website (build hg19/hg38).}

\item{impute}{Parameter used by \code{\link{grooMethy}}. If \code{TRUE}, K-Nearest Neighbouring
imputation will be applied to fill the missing values. Default = \code{FALSE}.}

\item{imputebyrow}{Parameter used by \code{\link{grooMethy}}. If \code{TRUE}, missing values will
be imputed using similar values in row (i.e., across samples); if \code{FALSE}, missing values
will be imputed using similar values in column (i.e., across CpGs). Default is \code{TRUE}.}

\item{verbose}{Logical parameter. Should the function be verbose?}
}
\value{
A \code{\link{REMProduct}} object containing profiled RE methylation results.
}
\description{
\code{remprofile} is used to extract profiled methylation of CpG sites in RE.
}
\examples{
data(Alu.hg19.demo)
if (!exists("GM12878_450k")) GM12878_450k <- getGM12878("450k")
remprofile.res <- remprofile(GM12878_450k,
                             REtype = "Alu",
                             annotation.source = "AH",
                             genome = "hg19",
                             RE = Alu.hg19.demo,
                             verbose = TRUE)
details(remprofile.res)
rempB(remprofile.res) # Methylation data (beta value)

remprofile.res <- rempAggregate(remprofile.res)
details(remprofile.res)
rempB(remprofile.res) # Methylation data (beta value)

}
