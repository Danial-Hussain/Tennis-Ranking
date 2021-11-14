module Algorithm

import Dates
using Dates

using ..Types

export updateRanking
export atp_ranking
export compute_points
export ATPNittoFinalsPoints
export ATPGrandSlamDoublesPoints
export ATP1000DoublesPoints
export ATP500DoublesPoints
export ATP250DoublesPoints
export ATPChallengerTour125DoublesPoints
export ATPChallengerTour110DoublesPoints
export ATPChallengerTour100DoublesPoints
export ATPChallengerTour90DoublesPoints
export ATPChallengerTour80DoublesPoints
export ITFWorldTennisTour25kPoints
export ITFWorldTennisTour15kPoints

include("constants.jl")
include("ranking.jl")
include("atp_ranking.jl")

end
