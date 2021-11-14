"""
    function Base.show(
        io::IO, 
        p::Player
    )

Prints out a player.

"""

function Base.show(io::IO, p::Player)
    return print(io, "Player: $(p.id)")
end

"""
    function strength(
        player::Player
    )::Float64

Calculates a player's strength

Arguments
=========
- `player`:
    the player for whose strenght to calculate.
"""

function strength(player::Player)::Float64
    return 1 / player.rankings["Ground Truth"]
end

"""
    function participationProbability(
        player::Player, 
        tournament::Tournament
    )::Float64

Calculates the probability a player plays a tournament.

Arguments
=========
- `player`:
    the player under consideration.
- `tournament`:
    the tournament to calculate a player's strength for.
"""

function participationProbability(
    player::Player,
    tournament::Tournament,
)::Float64
    return 0.95
end

"""
    function clear_doubles_results(
        players::Vector{Player}
    )

Clears the doubles results stored within a player struct.

Arguments
=========
- `players`:
    an array of players.
"""

function clear_doubles_results(players::Vector{Player})
    for player in players
        player.doubles_results = Dict{String,DoublesTournamentPlayerSummary}()
    end
    return nothing
end

"""
    function initialize_ranking_schemes(
        players::Vector{Player}
    )

Initializes the various ranking schemes with the burn in ranking.

Arguments
=========
- `players`:
    an array of players.
- `ranking_schemes`
    an array of the ranking schemes we want to initialize.
"""

function initialize_rankings_schemes(
    players::Vector{Player},
    ranking_schemes::Vector{String},
)
    for player in players
        for ranking_scheme in ranking_schemes
            if ranking_scheme != "Ground Truth"
                player.rankings[ranking_scheme] = player.rankings["Burn In"]
            end
        end
    end
    return nothing
end
