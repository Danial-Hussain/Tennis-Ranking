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
        ranking_scheme::String,
        players::Vector{Player}
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
- `players`:
    all the players in the simulation.
"""

function participationProbability(;
    player::Player,
    tournament::Tournament,
    ranking_scheme::String,
    players::Vector{Player}
)::Float64
    player_rank = player.rankings[ranking_scheme]
    N = length(players)
    n = length(filter(p -> p.rankings[ranking_scheme] < player_rank, players))
    ordinal_rank = N - n
    if ordinal_rank <= 50
        if tournament.type == "Grandslam"
            return 0.37
        elseif tournament.type == "ATPNitto"
            return 0.95
        elseif tournament.type == "ATP1000"
            return 0.62
        elseif tournament.type == "ATP500"
            return 0.53
        elseif tournament.type == "ATP250"
            return 0.29
        else
            return 0.05
        end
    elseif ordinal_rank <= 100
        if tournament.type == "Grandslam"
            return 0.27
        elseif tournament.type == "ATPNitto"
            return 0.90
        elseif tournament.type == "ATP1000"
            return 0.09
        elseif tournament.type == "ATP500"
            return 0.16
        elseif tournament.type == "ATP250"
            return 0.35
        else
            return 0.1
        end
    elseif ordinal_rank <= 200
        if tournament.type == "Grandslam"
            return 0.14
        elseif tournament.type == "ATPNitto"
            return 0.7
        elseif tournament.type == "ATP1000"
            return 0.09
        elseif tournament.type == "ATP500"
            return 0.14
        elseif tournament.type == "ATP250"
            return 0.14
        else
            return 0.15
        end
    elseif ordinal_rank <= 300
        if tournament.type == "Grandslam" 
            return 0.08
        elseif tournament.type == "ATPNitto"
            return 0.6
        elseif tournament.type == "ATP1000"
            return 0.07
        elseif tournament.type == "ATP500"
            return 0.06
        elseif tournament.type == "ATP250"
            return 0.06
        else
            return 0.20
        end
    elseif ordinal_rank <= 400
        if tournament.type == "Grandslam"
            return 0.04
        elseif tournament.type == "ATPNitto"
            return 0.5
        elseif tournament.type == "ATP1000"
            return 0.05
        elseif tournament.type == "ATP500"
            return 0.05
        elseif tournament.type == "ATP250"
            return 0.05
        else
            return 0.30
        end
    elseif ordinal_rank <= 500
        if tournament.type == "Grandslam"
            return 0.05
        elseif tournament.type == "ATPNitto"
            return 0.5
        elseif tournament.type == "ATP1000"
            return 0.05
        elseif tournament.type == "ATP500"
            return 0.05
        elseif tournament.type == "ATP250"
            return 0.05
        else
            return 0.40
        end
    elseif ordinal_rank <= 600
        if tournament.type == "Grandslam"
            return 0.05
        elseif tournament.type == "ATPNitto"
            return 0.5
        elseif tournament.type == "ATP1000"
            return 0.05
        elseif tournament.type == "ATP500"
            return 0.05
        elseif tournament.type == "ATP250"
            return 0.05
        else
            return 0.50
        end
    else
        if tournament.type == "Grandslam"
            return 0.05
        elseif tournament.type == "ATPNitto"
            return 0.4
        elseif tournament.type == "ATP1000"
            return 0.05
        elseif tournament.type == "ATP500"
            return 0.05
        elseif tournament.type == "ATP250"
            return 0.05
        else
            return 0.6
        end
    end
end


"""
    function clear_doubles_results(;
        players::Vector{Player}
    )

Clears the doubles results stored within a player struct.

Arguments
=========
- `players`:
    an array of players.
"""

function clear_doubles_results(;
    players::Vector{Player}
)
    for player in players
        player.doubles_results = Dict{String,DoublesTournamentPlayerSummary}()
        player.matches_played = 0
        player.tournaments_played = 0
    end
    return nothing
end


"""
    function initialize_rankings_schemes(;
        players::Vector{Player},
        ranking_schemes::Vector{String},
        verbose::Bool
    )

Initializes the various ranking schemes with the burn in ranking.

Arguments
=========
- `players`:
    an array of players.
- `ranking_schemes`
    an array of the ranking schemes we want to initialize.
"""

function initialize_rankings_schemes(;
    players::Vector{Player},
    ranking_schemes::Vector{String},
    verbose::Bool
)
    for player in players
        for ranking_scheme in ranking_schemes
            if ranking_scheme != "Ground Truth"
                player.rankings[ranking_scheme] = player.rankings["Burn In"]
            end
        end
    end
    if verbose 
        println("########")
        println("Ranking schemes initialized.")
        println("########")
        println()
    end
    return nothing
end


"""
    function update_player_ages(;
        players::Vector{Player},
        method::String,
        verbose::Bool
    )

Updates the age for each player in the simulation.

Arguments
=========
- `players`:
    an array of players.
- `method`
    how to initialize the rankings
    options:
    1) Random
    2) Increment
- `verbose`:
    conditional on whether to print results.
"""

function update_player_ages(;
    players::Vector{Player},
    method::String,
    verbose::Bool
)
    if method == "Random"
        for player in players
            player.age = rand(18:40)
        end
    elseif method == "Increment"
        for player in players
            player.age += 1
        end
    end
    if verbose
        println("########")
        if method == "Random"
            println("Player ages randomly initialized.")
        elseif method == "Increment"
            println("Player ages incremented.")
        end
        println("########")
        println()
    end
    return nothing
end