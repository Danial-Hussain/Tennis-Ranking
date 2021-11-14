import Dates
import Random

using Random
using Dates

include("types.jl")
include("agent/agent.jl")
include("algorithm/algorithm.jl")
include("event/event.jl")
include("metric/metric.jl")

using .Types
using .Agent
using .Algorithm
using .Event
using .Metric

"""
    function simulation(;
        player_count::Int64,
        seasons::Int64,
        burn_in_seasons::Int64,
        ranking_schemes::Vector{String}
    )

Simulates a tennis season.

Arguments
=========
- `player_count`:
    the number of players to create.
- `seasons`:
    the number of seasons to simulate.
- `burn_in_seasons`:
    the number of burn in seasons to use.
- `ranking_schemes`:
    which ranking algorithms to test.
"""

function simulation(;
    player_count::Int64,
    seasons::Int64,
    burn_in_seasons::Int64,
    ranking_schemes::Vector{String},
)
    # Set random seed for reproducability
    Random.seed!(42)

    # Generate a pool of players
    players = generate_players(player_count, ranking_schemes)

    # Genearte "Burn In" ranking
    burnin(players, burn_in_seasons)

    # Remove the saved doubles tournament results
    clear_doubles_results(players)

    # Initialize the ranking schemes with the burn in ranking
    initialize_rankings_schemes(players, ranking_schemes)

    # Run simulation for each ranking algorithm
    for ranking_scheme in ranking_schemes

        # Generate a pool of tournaments
        tournaments = generate_doubles_tournaments()
        sort!(tournaments, by = t -> t.date, alg = InsertionSort)

        # Simulate tournaments for each season
        for _ in 1:seasons
            # Simulate each tournament
            for tournament in tournaments
                play_doubles_tournament(
                    tournament = tournament,
                    players = players,
                    ranking_scheme = ranking_scheme,
                )
                updateRanking(
                    players = players,
                    ranking_scheme_to_apply = ranking_scheme,
                    ranking_scheme_to_update = ranking_scheme,
                )
                corr = correlation(
                    players = players,
                    ranking_scheme1 = ranking_scheme,
                    ranking_scheme2 = "Ground Truth",
                )
            end
        end
        clear_doubles_results(players)
    end
    return nothing
end

# Test run
simulation(
    player_count = 500,
    seasons = 1,
    burn_in_seasons = 1,
    ranking_schemes = Vector{String}(["ATP"]),
)
