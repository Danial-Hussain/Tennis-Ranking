module Types

import Dates
using Dates

export DoublesMatchPlayerSummary
export DoublesTournamentPlayerSummary
export Player
export Team
export Tournament

"""
    mutable struct DoublesMatchPlayerSummary
        opponent1_player_id::Int64
        opponent2_player_id::Int64
        result::String
        score::String
    end

An object containing information regarding a player's match results within a tournament.

Fields
=========
- `opponent1_player_id`:
    the opposing team's player1 id
- `opponent2_player_id`:
    the opposing team's player2 id
- `result`:
    whether the player won or lost the match.
    options:
        1) "Won"
        2) "Lost"
- `score`
    the score of the match
"""

mutable struct DoublesMatchPlayerSummary
    opponent1_player_id::Int64
    opponent2_player_id::Int64
    result::String
    score::String
    function DoublesMatchPlayerSummary(;
        opponent1_player_id,
        opponent2_player_id,
        result,
        score,
    )
        return new(opponent1_player_id, opponent2_player_id, result, score)
    end
end

"""
    mutable struct DoublesTournamentPlayerSummary 
        primary_player_id::Int64
        partner_player_id::Int64
        tournament_name::String
        tournament_type::String
        result::Int128
        matches::Vector{DoublesMatchPlayerSummary}
    end

An object containing information regarding a player's tournament results.

Fields
=========
- `primary_player_id`:
    the player's id.
- `partner_player_id`:
    the player's partner's id.
- `tournament_name`:
    the name of the tournament being played.
- `tournament_type`:
    the type of the tournament being played.
    options:
        1) Grandslam
        2) ATPNitto
        3) ATP1000
        4) ATP500
        5) ATP250
        6) ATPChallenger125
        7) ATPChallenger110
        8) ATPChallenger100
        9) ATPChallenger90
        10) ATPChallenger80 
        11) ITFWorldTennisTour25k
        12) ITFWorldTennisTour15k
- `result`
    the finishing spot of the player in the tournament.
    options:
        1) "Winner"
        2) "Finals"
        3) "Semi-Finals"
        4) "Quarter-Finals"
        5) "Round-16"
        6) "Round-32"
        7) "Round-64"
        8) "Round-128"
        9) "Qualified"
- `matches`
    an array of information for matches played in the tournament.
"""

mutable struct DoublesTournamentPlayerSummary
    primary_player_id::Int64
    partner_player_id::Int64
    tournament_name::String
    tournament_type::String
    result::String
    matches::Vector{DoublesMatchPlayerSummary}
    function DoublesTournamentPlayerSummary(;
        primary_player_id,
        partner_player_id,
        tournament_name,
        tournament_type,
        result,
        matches,
    )
        return new(
            primary_player_id,
            partner_player_id,
            tournament_name,
            tournament_type,
            result,
            matches,
        )
    end
end

"""
    mutable struct Player
        id::Int64
        rankings::Dict{String, Int}
        matches_played::Int128
        tournaments_played::Int128
        doubles_results::Dict{String, DoublesTournamentPlayerSummary}
    end

A tennis player.

Fields
=========
- `id`:
    a unique identifier for the player.
- `rankings`:
    contains all latest rankings for the player
        ex:
            Dict(
                "Ground Truth" => 1,
                "Burn In" => 38,
                "ATP" => 2,
                "Elo" => 17
            )
- `matches_played`:
    a count of the number of matches a player has played.
- `tournaments_played`:
    a count of the number of tournaments a player has played.
- `doubles_results`:
    the results of tournaments a player has played in.
        ex:
            Dict(
                "Wimbledon_2018-07-02" => DoublesTournamentPlayerSummary(
                    primary_player_id = 1,
                    partner_player_id = 2,
                    tournament_name = "Wimbledon",
                    tournament_type = "Grandslam",
                    result = "Winner",
                    matches = Vector{DoublesMatchPlayerSummary}([])
                ) 
            )
"""

mutable struct Player
    id::Int64
    rankings::Dict{String,Int}
    matches_played::Int128
    tournaments_played::Int128
    doubles_results::Dict{String,DoublesTournamentPlayerSummary}
    function Player(;
        id::Int64,
        ground_truth_ranking::Int64,
        burn_in_ranking::Int64,
        ranking_schemes::Vector{String},
    )
        id = id
        matches_played = 0
        tournaments_played = 0
        doubles_results = Dict{String,DoublesTournamentPlayerSummary}()
        rankings::Dict{String,Int} = Dict(
            "Ground Truth" => ground_truth_ranking,
            "Burn In" => burn_in_ranking,
        )
        for rankingScheme in ranking_schemes
            rankings[rankingScheme] = 0
        end
        return new(
            id,
            rankings,
            matches_played,
            tournaments_played,
            doubles_results,
        )
    end
end

"""
    mutable struct Team
        player1::Player
        player2::Player
        ranking::Int64
    end

An object containing two players to form a doubles pair.

Fields
=========
- `player1`:
    the first player in the team.
- `opponent2_player_id`:
    the second player in the team.
- `ranking`:
    the overall ranking of the team.
"""

mutable struct Team
    player1::Player
    player2::Player
    ranking::Int64
    function Team(player1::Player, player2::Player, ranking_scheme::String)
        player1 = player1
        player2 = player2
        p1_rank = get(player1.rankings, ranking_scheme, -1)
        p2_rank = get(player2.rankings, ranking_scheme, -1)
        (p1_rank != -1 && p2_rank != -1) ||
            throw(DomainError(ranking_scheme, "ranking scheme unavailable"))
        ranking = p1_rank + p2_rank
        return new(player1, player2, ranking)
    end
end

"""
    mutable struct Tournament
        id::String
        name::String
        date::Date
        type::String
        drawsize::Int64
    end

A tournament played during the tennis season.

Fields
=========
- `id`:
    a unique identifier for the tournament combining name and date
- `name`:
    the name of the tournament being played
- `date`:
    the date when the tournament was played
- `type`
    the type of the tournament
    options:
        1) Grandslam
        2) ATPNitto
        3) ATP1000
        4) ATP500
        5) ATP250
        6) ATPChallenger125
        7) ATPChallenger110
        8) ATPChallenger100
        9) ATPChallenger90
        10) ATPChallenger80 
        11) ITFWorldTennisTour25k
        12) ITFWorldTennisTour15k
- `drawsize`
    the draw size for the tournament
"""

mutable struct Tournament
    id::String
    name::String
    date::Date
    type::String
    drawsize::Int64
    function Tournament(;
        name::String,
        date::Date,
        type::String,
        drawsize::Int64,
    )
        id = string(name, "_", Dates.format(date, "yyyy-mm-dd"))
        return new(id, name, date, type, drawsize)
    end
end

end
