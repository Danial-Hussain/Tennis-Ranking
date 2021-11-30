"""
    function burnin(;
        players::Vector{Player},
        seasons::Int64,
        strength_method::String,
        verbose::Bool
    )

Generate an initial "burn in" ranking for the players.

Arguments
=========
- `players`:
    an array of players in the simulation.
- `seasons`:
    the number of seasons to simulate.
- `strength_method`:
    the method to determine probability team 1 beats team 2.
"""

function burnin(;
    players::Vector{Player},
    seasons::Int64,
    strength_method::String,
    verbose::Bool
)
    tournaments = generate_doubles_tournaments()
    sort!(tournaments, by = t -> t.date, alg=InsertionSort)

    # Simulate tournaments for each season
    for _ in 1:seasons
        # Simulate each tournament
        for tournament in tournaments
            play_doubles_tournament(
                tournament = tournament, 
                players = players, 
                ranking_scheme = "Burn In",
                strength_method = strength_method,
                verbose = verbose
            )
            updateRanking(
                players = players, 
                ranking_scheme_to_apply = "ATP",
                ranking_scheme_to_update = "Burn In",
                last_tournament_id = tournament.id,
                verbose = verbose
            )
        end
    end
end