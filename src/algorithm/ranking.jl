"""
    function updateRanking(;
        players::Vector{Player},
        ranking_scheme_to_apply::String,
        ranking_scheme_to_update::String
    )

This function is used to update the player's rankings after a tournament.

Arguments
=========
- `players`:
    an array of players in the simulation.
- `ranking_scheme_to_apply`:
    the ranking scheme to apply.
- `ranking_scheme_to_update`:
    the ranking_scheme to update for the player.
"""

function updateRanking(;
    players::Vector{Player},
    ranking_scheme_to_apply::String,
    ranking_scheme_to_update::String
)
    if ranking_scheme_to_apply == "ATP"
        atp_ranking(players, ranking_scheme_to_update)
    else
        throw(
            DomainError(
                ranking_scheme, 
                "unsupported ranking scheme"
            )
        )
    end
end