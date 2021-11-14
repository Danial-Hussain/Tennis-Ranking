module Event

import Dates
using Dates

using ..Types
using ..Agent
using ..Algorithm

export burnin
export generate_doubles_tournaments
export play_doubles_match
export play_doubles_tournament
export round_to_result
export generate_bracket, execute_bracket

include("burnin.jl")
include("generate_doubles_tournaments.jl")
include("play_doubles_match.jl")
include("play_doubles_tournament.jl")
include("round_to_result.jl")
include("tournament_bracket.jl")

end