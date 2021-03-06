\name{plot.insilico}
\alias{plot.insilico}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{plot CSMF from a "insilico" object}
\description{
Produce a bar plot of the CSMFs for a fitted \code{"insilico"} object.
}
\usage{
\method{plot}{insilico}(x, type = c("errorbar", "bar", "compare")[1], 
  top = 10, causelist = NULL, which.sub = NULL, 
  xlab = "Causes", ylab = "CSMF", title = "Top CSMF Distribution", 
  horiz = TRUE, angle = 60, fill = "lightblue", 
  err_width = .4, err_size = .6, point_size = 2, 
  border = "black", bw = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
fitted \code{"insilico"} object}
  \item{type}{An indicator of the type of chart to plot. "errorbar" for line plots of only the error bars on single population; "bar" for bar chart with error bars on single population; "compare" for line charts on multiple sub-populations.}
  \item{top}{The number of top causes to plot. If multiple sub-populations are to be plotted, it will plot the union of the top causes in all sub-populations.}
  \item{causelist}{The list of causes to plot. It could be a numeric vector indicating the position of the causes in the InterVA cause list (see \code{\link{causetext}}), or a vector of character string of the cause names. The argument supports partial matching of the cause names. e.g., "HIV/AIDS related death" could be abbreviated into "HIV"; "Other and unspecified infect dis" could be abbreviated into "Other and unspecified infect".}
  \item{which.sub}{Specification of which sub-population to plot if there are multiple and \code{type} is set to "bar".}
  \item{xlab}{Labels for the causes.}
  \item{ylab}{Labels for the CSMF values.}
  \item{title}{Title of the plot.}
  \item{horiz}{Logical indicator indicating if the bars are plotted horizontally.}
  \item{angle}{Angle of rotation for the texts on x axis when \code{horiz} is set to FALSE}
  \item{fill}{The color to fill the bars when \code{type} is set to "bar". }
  \item{border}{The color to color the borders of bars when \code{type} is set to "bar".}
  \item{err_width}{Size of the error bars.}
  \item{err_size}{Thickness of the error bar lines.}
  \item{point_size}{Size of the points.}
  \item{bw}{Logical indicator for setting the theme of the plots to be black and white.}
  \item{\dots}{Not used.}
}

\details{
To-do
}

\author{
Zehang Li, Tyler McCormick, Sam Clark

Maintainer: Zehang Li <lizehang@uw.edu>

}
\references{
Tyler H. McCormick, Zehang R. Li, Clara Calvert, Amelia C. Crampin, Kathleen Kahn and Samuel J. Clark Probabilistic cause-of-death assignment using verbal autopsies, \emph{arXiv preprint arXiv:1411.3042} \url{http://arxiv.org/abs/1411.3042} (2014)
}
\keyword{ InSilicoVA }


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{insilico}}, \code{\link{summary.insilico}}
}
\examples{
# load sample data together with sub-population list
data(SampleInput_insilico)
# extract INterVA style input data
data <- SampleInput_insilico$data
# extract sub-population information. 
# The groups are "HIV Positive", "HIV Negative" and "HIV status unknown".
subpop <- SampleInput_insilico$subpop

# run without sub-population
fit1<- insilico( data, subpop = NULL, 
              length.sim = 400, burnin = 200, thin = 10 , seed = 1,
              external.sep = TRUE, keepProbbase.level = TRUE)
# default plot
plot(fit1)

# customized line plot
plot(fit1, top = 15, horiz = FALSE, fill = "gold", 
		   bw = TRUE, title = "Top 15 CSMFs", angle = 70, 
       err_width = .2, err_size = .6, point_size = 2)

# customized bar plot
plot(fit1, type = "bar", top = 15, horiz = TRUE, 
       bw = TRUE, title = "Top 15 CSMFs", angle = 70, 
       err_width = .5, err_size = .6)

# run with sub-populations
fit2<- insilico( data, subpop = subpop, 
              length.sim = 400, burnin = 200, thin = 10 , seed = 1,
              external.sep = TRUE, keepProbbase.level = TRUE)
# default plot
plot(fit2, type = "compare", top = 5, title = "Top 5 causes comparison")
# customized single sub-population plot
plot(fit2, which.sub = "Unknown", 
	 title = "Top 10 causes in HIV status unknown population")
# customized plot with specified causes, with abbreviation here.
some_causes <- c("HIV", "Pulmonary", 
				"Other and unspecified infect dis")
plot(fit2, type = "compare", horiz = FALSE,  causelist = some_causes,
		   title = "Infectious diseases in three sub-populations", 
		   angle = 20)

}

