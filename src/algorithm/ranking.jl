"""
    function updateRanking(;
        players::Vector{Player},
        ranking_scheme_to_apply::String,
        ranking_scheme_to_update::String,
        last_tournament_id::String,
        verbose::Bool
    )

This function is used to update the player's rankings after a tournament.

Arguments
=========
- `players`:
    an array of players in the simulation.
- `ranking_scheme_to_apply`:
    the ranking scheme to apply.
    options:
    1) "ATP"
    2) "Elo"
    3) "Dwz"
- `ranking_scheme_to_update`:
    the ranking_scheme to update for the player.
- `last_tournament_id`:
    the identifier for the last tournament that was played.
- `verbose`:
    whether to print the results.
"""

function updateRanking(;
    players::Vector{Player},
    ranking_scheme_to_apply::String,
    ranking_scheme_to_update::String,
    last_tournament_id::String,
    verbose::Bool
)
    if ranking_scheme_to_apply == "ATP"
        atp_ranking(players, ranking_scheme_to_update)
    elseif ranking_scheme_to_apply == "Elo"
        elo_ranking(players, ranking_scheme_to_update, last_tournament_id)
    elseif ranking_scheme_to_apply == "Dwz"
        dwz_ranking(players, ranking_scheme_to_update, last_tournament_id)
    else
        throw(DomainError(ranking_scheme, "unsupported ranking scheme"))
    end
    if verbose
        println("########")
        println("$ranking_scheme_to_update updated with $ranking_scheme_to_apply")
        println("########")
        println()
    end
    return nothing
end