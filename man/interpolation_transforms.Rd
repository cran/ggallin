% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transforms.R
\name{interp_trans}
\alias{interp_trans}
\alias{warp_trans}
\title{Interpolation based scale transforms.}
\usage{
interp_trans(x=NULL,y=NULL,data=NULL,na.rm=TRUE,breaks=NULL,format=NULL)

warp_trans(x=NULL,w=NULL,data=NULL,na.rm=TRUE,breaks=NULL,format=NULL)
}
\arguments{
\item{x}{the \eqn{x} coordinates for linear interpolation.}

\item{y}{the \eqn{y} coordinates for linear interpolation.}

\item{data}{A \code{data.frame} with columns of \code{x} and \code{y}
for \code{interp_trans} or \code{x} and \code{w} for
\code{warp_trans}. If \code{data} is given, it takes precedence over
the given \code{x, y, w}.}

\item{na.rm}{If \code{TRUE}, then missing \code{x} or \code{y} will
be removed.}

\item{breaks}{default breaks function for this transformation. The breaks
function is applied to the raw data.}

\item{format}{default format for this transformation. The format is applied
to breaks generated to the raw data.}

\item{w}{the \eqn{w} coordinates for the \sQuote{warp} interpolation.
The cumulative sum of \code{w} are computed then fed to the
interpolation transform.}
}
\value{
A scale transformation object.
}
\description{
Interpolation based scale transformations. The user supplies \eqn{x} and
\eqn{y} (which should be monotonic increasing or decreasing in \eqn{x}) 
to create a scale transformation based on linear interpolation. 

A \sQuote{warp} transformation is also supported wherein the user supplies
\eqn{x} and \eqn{w} where, after sorting on \eqn{x}, the cumulative sum
of \eqn{w} are used as the \eqn{y} in an interpolation transformation.
Here \eqn{w} are the rate of increase, or \sQuote{weights}.
}
\examples{
set.seed(1234)
ggplot(data.frame(x=rnorm(100),y=runif(100)),aes(x=x,y=y)) + 
  geom_point() + 
  scale_x_continuous(trans=interp_trans(x=seq(-10,10,by=1),y=cumsum(runif(21))))

set.seed(1234)
ggplot(data.frame(x=rnorm(100),y=runif(100)),aes(x=x,y=y)) + 
  geom_point() + 
  scale_x_continuous(trans=warp_trans(x=seq(-10,10,by=1),w=runif(21)))

# equivalently:
set.seed(1234)
ggplot(data.frame(x=rnorm(100),y=runif(100)),aes(x=x,y=y)) + 
  geom_point() + 
  scale_x_continuous(trans=warp_trans(data=data.frame(x=seq(-10,10,by=1),w=runif(21))))

# this is like trans_sqrt:
set.seed(1234)
myx <- seq(0,5,by=0.01)
ggplot(data.frame(x=rnorm(100),y=runif(100)),aes(x=x,y=y)) + 
  geom_point() + 
  scale_y_continuous(trans=interp_trans(x=myx,y=sqrt(myx)))

}
\seealso{
\code{\link[scales]{trans_new}}.
}
\author{
Steven E. Pav \email{shabbychef@gmail.com}
}
\keyword{plotting}
