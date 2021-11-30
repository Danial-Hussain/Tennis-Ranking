using Random

"""
    function generate_players(;
        dataset_size::Int64,
        ranking_schemes::Vector{String},
        verbose::Bool
    )::Vector{Player}

Generates an array of players. 

Arguments
=========
- `dataset_size`:
    the number of players to create.
- `ranking_schemes`:
    the ranking algorithms that will be applied.
- `verbose`:
    conditional on whether to print results.
"""

function generate_players(;
    dataset_size::Int64,
    ranking_schemes::Vector{String},
    verbose::Bool
)::Vector{Player}
    players = Vector{Player}([])
    burn_in_rankings = shuffle!(Vector{Int64}(collect(1:dataset_size)))
    for i in 1:dataset_size
        ground_truth_ranking = i
        burn_in_ranking = burn_in_rankings[i]
        p = Player(
            id = i,
            ground_truth_ranking = ground_truth_ranking,
            burn_in_ranking = burn_in_ranking,
            ranking_schemes = ranking_schemes,
        )
        push!(players, p)
    end
    if verbose
        players_count = length(players)
        println("########")
        println("Vector of $players_count created.")
        println("########")
        println()
    end
    return players
end
