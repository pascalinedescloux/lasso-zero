% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/methods.R
\name{print.lass0}
\alias{print.lass0}
\title{Print a lass0 object}
\usage{
\method{print}{lass0}(x, ...)
}
\arguments{
\item{x}{a \code{"lass0"} object.}

\item{...}{additional print arguments.}
}
\description{
Print a summary of the Lasso-Zero estimate
}
\details{
The call that produced the object \code{x} is printed, followed by the
estimated regression coefficients and intercept.
}
\references{
Descloux, P., & Sardy, S. (2018). Model selection with
  lasso-zero: adding straw to the haystack to better find needles. arXiv
  preprint arXiv:1805.05133. \url{https://arxiv.org/abs/1805.05133}
}
\seealso{
\code{\link{lass0}} and \code{\link{plot.lass0}}
}
