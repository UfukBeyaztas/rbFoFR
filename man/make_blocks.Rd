\name{make_blocks}
\alias{make_blocks}
\title{Disjoint Block System of the Localized Basis}
\description{
Builds the pairwise disjoint supports \eqn{I_1, \dots, I_K \subset (0,1)} of
the localized predictor basis.
}
\usage{
make_blocks(centers = c(0.075, 0.445, 0.845), per_cluster = 2,
            width = 0.03, gap = 0.06)
}
\arguments{
  \item{centers}{cluster centres in \eqn{(0,1)}.}
  \item{per_cluster}{number of blocks in each cluster.}
  \item{width}{common block width.}
  \item{gap}{distance between neighbouring block centres within a
    cluster.}
}
\details{
Blocks in the same cluster are close together, so a short window can reveal
them jointly. Blocks in different clusters are far apart, so no window of
moderate length reveals both. The default gives the six supports used in
the paper, with centres 0.045, 0.105, 0.415, 0.475, 0.815 and 0.875 and
width 0.03.

An error is returned if two blocks overlap, because disjoint supports are
required by the localized-score model.
}
\value{
A list with the ordered lower and upper endpoints (\code{lower},
\code{upper}), the cluster of each block (\code{cluster}), and the number of
blocks \code{K}.
}
\seealso{\code{\link{phi_basis}}, \code{\link{resolution_order}}}
\examples{
\dontrun{
b <- make_blocks()
cbind(b$lower, b$upper)

## the four-block system of design 5
make_blocks(centers = c(0.14, 0.38, 0.62, 0.86), per_cluster = 1,
            width = 0.18, gap = 0.01)
}
}
\keyword{manip}
