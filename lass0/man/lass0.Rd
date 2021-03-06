% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lass0.R
\name{lass0}
\alias{lass0}
\title{Variable selection for linear regression with Lasso-Zero}
\usage{
lass0(X, y, tau, alpha, q = nrow(X), M = 30, sigma = NULL,
  intercept = TRUE, standardizeX = TRUE, standardizeG = NULL,
  qut.MC.output = NULL, GEVapprox = TRUE, parallel = FALSE,
  soft.thresholding = FALSE, ols = TRUE, ...)
}
\arguments{
\item{X}{input matrix of dimension \code{n x p}; each row is an observation
vector.}

\item{y}{response vector of size \code{n}.}

\item{tau}{a positive threshold value. If missing, then \code{alpha} must be
supplied.}

\item{alpha}{level of the quantile universal threshold (number between 0 and
1). If missing, then \code{tau} must be supplied.}

\item{q}{size of noise dictionaries. A noise dictionary consists in a
Gaussian matrix G of size \code{n x q} concatenated horizontally to the
input matrix X. Default is \code{q = nrow(X)}.}

\item{M}{number of noise dictionaries used.}

\item{sigma}{standard deviation of the noise. If \code{sigma = NULL}
(default) and \code{tau = NULL}, the quantile universal threshold is
computed based on a pivotal statistic.}

\item{intercept}{whether an intercept should be fitted. If \code{TRUE}
(default), \code{y} and the columns of \code{X} are mean-centered before
the analysis, and the intercept is estimated by \code{mean(y) - colMeans(X)
\%*\% coefficients}.}

\item{standardizeX}{whether the columns of \code{X} should be standardized to
have unit standard deviation. Default is \code{TRUE}.}

\item{standardizeG}{either a positive numerical value indicating the desired
Euclidean norm of all columns of the noise dictionaries, or a logical value
indicating whether the columns of the noise dictionaries should be
standardized to have unit standard deviation. If \code{NULL} (default),
then it is set to \code{standardizeG = standardizeX}.}

\item{qut.MC.output}{an object of type \code{"qut.MC"} (output of
\code{qut.MC} function), providing the result of Monte Carlo simulations
necessary for the approximation of the Quantile Universal Threshold. By
default, \code{qut.MC.output = NULL} and the \code{qut.MC} function is
called unless \code{tau} is supplied.}

\item{GEVapprox}{whether to approximate the distribution of the null
thresholding statistic by a GEV distribution (ignored if \code{tau} is
supplied). Default is \code{TRUE}.}

\item{parallel}{if \code{TRUE}, use parallel \code{foreach} to make
computations with different noise dictionaries and to perform Monte Carlo
simulations for estimating the quantile universal threshold. Must register
parallel beforehand, e.g. with \code{doParallel}. Default is \code{FALSE}.}

\item{soft.thresholding}{if \code{TRUE}, the coefficients are soft
thresholded (rather than hard thresholded) at level \code{tau}. Default is
\code{FALSE}.}

\item{ols}{whether to refit the nonzero coefficients with an ordinary least
squares procedure. Default is \code{TRUE}.}

\item{...}{further arguments that can be passed to \code{qut.MC}.}
}
\value{
An object of class \code{"lass0"}. It is a list containing the
  following components: \item{coefficients}{estimated regression
  coefficients.} \item{intercept}{intercept value.}
  \item{fitted.values}{fitted values.} \item{residuals}{residuals.}
  \item{selected}{set of selected features.} \item{tau}{threshold value.}
  \item{Betas}{matrix of size \code{p x M} containing the values of the
  \code{M} estimates for the regression coefficients (on the standardized
  scale if \code{standardizeX = TRUE}).} \item{Gammas}{matrix of size \code{q
  x M} containing the values of the \code{M} obtained noise coefficient
  vectors (on the standardized scale unless \code{standardizeG = FALSE}).}
  \item{madGammas}{statistics based on the noise coefficients, corresponding
  to the MAD of all nonzero entries in \code{Gammas}} \item{sdsX}{standard
  deviations of all columns of \code{X}. Can be used to transform
  \code{Betas} to the original scale doing \code{Betas / sdsX}.}
  \item{qut.MC.output}{either the list returned by \code{qut.MC}, or a character string
  explaining why \code{qut.MC} was not called.} \item{call}{matched call.}
}
\description{
Fits a (possibly high-dimensional) linear model with Lasso-Zero. Lasso-Zero
aggregates several estimates obtained by solving the basis pursuit problem
after concatenating random noise dictionaries to the input matrix. The
procedure is described in more details in the paper linked to in the
References section below.
}
\examples{
#### EXAMPLE 1: fast example with 5x10 input matrix and a small number 
#### (MCrep = 50) of Monte Carlo replications for computing QUT.

set.seed(201)
## design matrix
n <- 5
p <- 10
X <- matrix(rnorm(n*p), n, p)
## sparse vector
S0 <- 1:2 # support
beta0 <- rep(0, p)
beta0[S0] <- 2
## response:
y <- X[, S0] \%*\% beta0[S0] + rnorm(n)
## lasso-zero:
lass0.obj <- lass0(X, y, alpha = 0.05, MCrep = 50)
betahat <- lass0.obj$coefficients
plot(lass0.obj)


#### EXAMPLE 2: with 50x100 input matrix

\donttest{
set.seed(202)
## design matrix
n <- 50
p <- 100
X <- matrix(rnorm(n*p), n, p)
## sparse vector
S0 <- 1:3 # support
beta0 <- rep(0, p)
beta0[S0] <- 2
## response:
y <- X[, S0] \%*\% beta0[S0] + rnorm(n)

## 1) lasso-zero tuned by QUT with unknown noise level
lass0.obj1 <- lass0(X, y, alpha = 0.05)
betahat1 <- lass0.obj1$coefficients
plot(lass0.obj1)

## 2) lasso-zero tuned by QUT with known noise level
lass0.obj2 <- lass0(X, y, alpha = 0.05, sigma = 1)
betahat2 <- lass0.obj2$coefficients

## 3) lasso-zero with fixed threshold tau = 1
lass0.obj3 <- lass0(X, y, tau = 1)
betahat3 <- lass0.obj3$coefficients
}

}
\references{
Descloux, P., & Sardy, S. (2018). Model selection with
  lasso-zero: adding straw to the haystack to better find needles. arXiv
  preprint arXiv:1805.05133. \url{https://arxiv.org/abs/1805.05133}
}
\seealso{
\code{\link{qut.MC}}
}
