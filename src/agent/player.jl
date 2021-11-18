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
    the player for whose strength to calculate.
"""

function strength(
    player::Player
)::Float64
    return 1 / player.rankings["Ground Truth"]
end


"""
    function participationProbability(;
        player::Player,
        tournament::Tournament,
        ranking_scheme::String
    )::Float64

Calculates the probability a player plays a tournament.

Arguments
=========
- `player`:
    the player under consideration.
- `tournament`:
    the tournament to calculate a player's strength for.
- `ranking_scheme`:
    the player's current ranking to use to determine participation probability.
"""

function participationProbability(;
    player::Player,
    tournament::Tournament,
    ranking_scheme::String
)::Float64
    player_rank = player.rankings[ranking_scheme]
    if player_rank <= 100
        if tournament.type == "Grandslam" || tournament.type == "ATPNitto"
            return 0.95
        elseif tournament.type == "ATP1000"
            return 0.90
        elseif tournament.type == "ATP500"
            return 0.75
        elseif tournament.type == "ATP250"
            return 0.30
        else
            return 0.05
        end
    elseif player_rank <= 200
        if tournament.type == "Grandslam" || tournament.type == "ATPNitto"
            return 0.70
        elseif tournament.type == "ATP1000"
            return 0.80
        elseif tournament.type == "ATP500"
            return 0.90
        elseif tournament.type == "ATP250"
            return 0.95
        else
            return 0.05
        end
    elseif player_rank <= 300
        if tournament.type == "Grandslam" || tournament.type == "ATPNitto"
            return 0.3
        elseif tournament.type == "ATP1000"
            return 0.5
        elseif tournament.type == "ATP500"
            return 0.75
        elseif tournament.type == "ATP250"
            return 0.80
        else
            return 0.95
        end
    else
        if tournament.type == "Grandslam" || tournament.type == "ATPNitto"
            return 0.20
        elseif tournament.type == "ATP1000"
            return 0.40
        elseif tournament.type == "ATP500"
            return 0.80
        elseif tournament.type == "ATP250"
            return 0.90
        else
            return 0.95
        end
    end
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
