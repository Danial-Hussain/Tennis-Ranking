"""
    function form_teams(
        method::String
        players::Array{Player}
    )::Array{Team}

Creates an array of teams from the given input of players.

Arguments
=========
- `method`:
    the strategy for forming teams.
    current strategies include:
        - "Next Best Player" 
            assigns each player to be partners with the next best available player.
- `players`
    an array of players from which to form teams.
- `ranking_scheme`
    ranking scheme used to evaluate the players
"""

function form_teams(
    method::String,
    players::Array{Player},
    ranking_scheme::String,
)::Array{Team}
    if method == "Next Best Player"
        teams = []
        for i in 1:2:length(players)
            t = Team(players[i], players[i+1], ranking_scheme)
            push!(teams, t)
        end
        return teams
    else
        throw(
            DomainError(
                method,
                "please select from the following options:\n
                 1. Next Best Player",
            ),
        )
    end
end
