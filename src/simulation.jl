module TennisRanking

export simulation

import Dates
import Random

using Random
using Dates
using StatsBase
using Plots

include("types/types.jl")

include("agent/form_teams.jl")
include("agent/generate_players.jl")
include("agent/player.jl")
include("agent/team.jl")

include("algorithm/constants.jl")
include("algorithm/ranking.jl")
include("algorithm/atp_ranking.jl")
include("algorithm/elo_ranking.jl")

include("event/burnin.jl")
include("event/generate_doubles_tournaments.jl")
include("event/play_doubles_match.jl")
include("event/play_doubles_tournament.jl")
include("event/round_to_result.jl")
include("event/tournament_bracket.jl")

include("metric/correlation.jl")
include("metric/calculate_metric.jl")
include("metric/save_plot.jl")


"""
    function simulation(;
        player_count::Int64,
        seasons::Int64,
        number_of_replications::Int64,
        burn_in_seasons::Int64,
        ranking_schemes::Vector{String},
        metrics::Vector{String},
        verbose::Bool,
        strength_method::String
    )

Simulates a tennis season.

Arguments
=========
- `player_count`:
    the number of players to create.
- `seasons`:
    the number of seasons to simulate.
- `number_of_replications`:
    the number of times to repeat the simulation.
- `burn_in_seasons`:
    the number of burn in seasons to use.
- `ranking_schemes`:
    which ranking algorithms to test.
    options:
        1) "ATP"
        2) "Elo"
        3) "Dwz"
- `metrics`:
    the metrics to be evaluated during the simulation.
    options:
        1) Spearman Correlation
        2) Kendall Tau Correlation
- `verbose`:
    whether to print each stage of the simulation.
    options:
        1) true
        2) false
- `strength_method`:
    method to determine the probability team 1 beats team 2.
    options:
        1) "BT" - Bradley Terry Model
        2) "BT_Exp" - Bradley Terry Exponential Model
"""

function simulation(;
    player_count::Int64,
    seasons::Int64,
    number_of_replications::Int64,
    burn_in_seasons::Int64,
    ranking_schemes::Vector{String},
    metrics::Vector{String},
    verbose::Bool,
    strength_method::String
)
    # Set random seed for reproducability
    # Random.seed!(42)

    # Generate a pool of players
    players = generate_players(
        dataset_size = player_count, 
        ranking_schemes = ranking_schemes, 
        verbose = verbose
    )

    # Initialize each player's age
    update_player_ages(
        players = players, 
        method = "Random", 
        verbose = verbose
    )

    # Generate "Burn In" ranking
    burnin(
        players = players, 
        seasons = burn_in_seasons, 
        strength_method = strength_method,
        verbose = verbose
    )

    # Remove the saved doubles tournament results
    clear_doubles_results(players = players)

    # Initialize the ranking schemes with the burn in ranking
    initialize_rankings_schemes(
        players = players, 
        ranking_schemes = ranking_schemes, 
        verbose = verbose
    )

    # Run simulation for each ranking algorithm
    for ranking_scheme in ranking_schemes

        # Generate a pool of tournaments
        tournaments = generate_doubles_tournaments()
        sort!(tournaments, by = t -> t.date, alg = InsertionSort)

        # Store the metrics calculated
        computed_metrics::Dict{String, Vector{Float64}} = Dict()
        for metric in metrics
            computed_metrics[metric] = Vector{Float64}(undef, length(tournaments)*seasons)
            fill!(computed_metrics[metric], 0)
        end

        # Run simulation x number of times
        for _ in 1:number_of_replications
            # Simulate tournaments for each season
            for season_idx in 1:seasons
                # Simulate each tournament
                for (tournament_idx, tournament) in enumerate(tournaments)
                    index = tournament_idx * season_idx
                    # Play the tournament
                    play_doubles_tournament(
                        tournament = tournament,
                        players = players,
                        ranking_scheme = ranking_scheme,
                        strength_method = strength_method,
                        verbose = verbose
                    )
                    # Update the ranking
                    updateRanking(
                        players = players,
                        ranking_scheme_to_apply = ranking_scheme,
                        ranking_scheme_to_update = ranking_scheme,
                        last_tournament_id = tournament.id,
                        verbose = verbose
                    )
                    # Calculate the desired metrics
                    for metric in metrics
                        value = calculate_metric(
                            metric = metric, 
                            players = players,
                            ranking_scheme1 = ranking_scheme,
                            ranking_scheme2 = "Ground Truth"
                        )
                        computed_metrics[metric][index] += value
                    end
                end
                # A year has past so increase every player's age
                update_player_ages(
                    players = players, 
                    method = "Increment",
                    verbose = verbose
                )
            end
            # Clear the rankings
            clear_doubles_results(players = players)
        end

        # Average the metrics
        for metric in metrics
            for value in computed_metrics[metric]
                value = value / number_of_replications
            end
        end

        # Plot the results
        for metric in metrics
            save_plot(
                y_var = computed_metrics[metric],
                title = "$metric using $ranking_scheme over $number_of_replications replications",
                f_name = "$metric-$ranking_scheme ranking",
                xlabel="Tournament #",
                ylabel="$metric",
                tournaments=repeat(tournaments, seasons)
            ) 
        end
    end
    return nothing
end

end