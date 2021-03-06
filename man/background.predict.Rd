% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/background.predict.R
\name{background.predict}
\alias{background.predict}
\title{Calculate prediction areas}
\usage{
background.predict(
  object,
  comp.predicted = 1,
  dist = "max.dist",
  xlim = NULL,
  ylim = NULL,
  resolution = 100
)
}
\arguments{
\item{object}{A list of data sets (called 'blocks') measured on the same
samples. Data in the list should be arranged in matrices, samples x
variables, with samples order matching in all data sets.}

\item{comp.predicted}{Matrix response for a multivariate regression
framework. Data should be continuous variables (see block.splsda for
supervised classification and factor reponse)}

\item{dist}{distance to use to predict the class of new data, should be a
subset of \code{"centroids.dist"}, \code{"mahalanobis.dist"} or
\code{"max.dist"} (see \code{\link{predict}}).}

\item{xlim, ylim}{numeric list of vectors of length 2, giving the x and y
coordinates ranges for the simulated data. By default will be \eqn{1.2*} the
range of object$variates$X[,i]}

\item{resolution}{A total of \code{resolution*resolution} data are simulated
between xlim[1], xlim[2], ylim[1] and ylim[2].}
}
\value{
\code{background.predict} returns a list of coordinates to be used
with \code{\link{polygon}} to draw the predicted area for each class.
}
\description{
Calculate prediction areas that can be used in plotIndiv to shade the
background.
}
\details{
\code{background.predict} simulates \code{resolution*resolution} points
within the rectangle defined by xlim on the x-axis and ylim on the y-axis,
and then predicts the class of each point (defined by two coordinates). The
algorithm estimates the predicted area for each class, defined as the 2D
surface where all points are predicted to be of the same class. A polygon is
returned and should be passed to \code{\link{plotIndiv}} for plotting the
actual background.

Note that by default xlim and ylim will create a rectangle of simulated data
that will cover the plotted area of \code{plotIndiv}. However, if you use
\code{plotIndiv} with \code{ellipse=TRUE} or if you set \code{xlim} and
\code{ylim}, then you will need to adapt \code{xlim} and \code{ylim} in
\code{background.predict}.

Also note that the white frontier that defines the predicted areas when
plotting with \code{plotIndiv} can be reduced by increasing
\code{resolution}.

More details about the prediction distances in \code{?predict} and the
supplemental material of the mixOmics article (Rohart et al. 2017).
}
\examples{
# Example 1
# -----------------------------------
data(breast.tumors)
X <- breast.tumors$gene.exp
Y <- breast.tumors$sample$treatment

splsda.breast <- splsda(X, Y,keepX=c(10,10),ncomp=2)

# calculating background for the two first components, and the centroids distance

background = background.predict(splsda.breast, comp.predicted = 2, dist = "centroids.dist")

\dontrun{
# default option: note that the outcome color is included by default!
plotIndiv(splsda.breast, background = background, legend=TRUE)

# Example 2
# -----------------------------------
data(liver.toxicity)
X = liver.toxicity$gene
Y = as.factor(liver.toxicity$treatment[, 4])

plsda.liver <- plsda(X, Y, ncomp = 2)

# calculating background for the two first components, and the mahalanobis distance
background = background.predict(plsda.liver, comp.predicted = 2, dist = "mahalanobis.dist")

plotIndiv(plsda.liver, background = background, legend = TRUE)


}

}
\references{
Rohart F, Gautier B, Singh A, Lê Cao K-A. mixOmics: an R package
for 'omics feature selection and multiple data integration. PLoS Comput Biol
13(11): e1005752
}
\seealso{
\code{\link{plotIndiv}}, \code{\link{predict}},
\code{\link{polygon}}.
}
\author{
Florian Rohart, Al J Abadi
}
