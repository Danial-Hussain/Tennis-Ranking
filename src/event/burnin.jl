"""
    function burnin(
        players::Vector{Player},
        seasons::Int64
    )

Generate an initial "burn in" ranking for the players.

Arguments
=========
- `players`:
    an array of players in the simulation.
- `seasons`:
    the number of seasons to simulate.
"""

function burnin(
    players::Vector{Player},
    seasons::Int64
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
                ranking_scheme = "Burn In"
            )
            updateRanking(
                players = players, 
                ranking_scheme_to_apply = "ATP",
                ranking_scheme_to_update = "Burn In"
            )
        end
    end
end