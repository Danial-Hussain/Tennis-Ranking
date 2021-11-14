module Agent

import Dates
using Dates

using ..Types

export form_teams
export generate_players
export strength
export participationProbability
export clear_doubles_results
export initialize_rankings_schemes
export probabilityOfWinning

include("form_teams.jl")
include("generate_players.jl")
include("player.jl")
include("team.jl")

end
