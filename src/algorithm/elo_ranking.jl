"""
    function elo_ranking(
        players::Vector{Player},
        ranking_scheme_to_update::String,
        last_tournament_id::String
    )

Update the player's rankings using Elo Ranking system.
Computed after the completion of a tournament.
A player's ranking is not updated after the result of each match.
The ranking for each team is computed as average of individual player rankings.
K factor is calculated by dividing 800 by the number of games a player's rating is based on
plus the number of games the player completed in a tournament.

Arguments
=========
- `players`:
    an array of players in the simulation.
- `ranking_scheme_to_update`:
    the name of the ranking scheme to update for each Player.
- `last_tournament_id`:
    the last tournament that was completed.
"""

function elo_ranking(
    players::Vector{Player},
    ranking_scheme_to_update::String,
    last_tournament_id::String
)
    updatedRankings = Dict{Int64, Int64}();
    for player in players
        if haskey(player.doubles_results, last_tournament_id)
            expected_score = 0
            actual_score = 0
            teammate_id = player.doubles_results[last_tournament_id].partner_player_id
            teammate_ranking = search_elo_ranking(teammate_id, players)
            for match in player.doubles_results[last_tournament_id].matches
                RA = (player.rankings["Elo"] + teammate_ranking) / 2
                RB = search_elo_ranking(match.opponent1_player_id, players) + search_elo_ranking(match.opponent2_player_id, players)
                EA = 1 / (1 + 10^((RB-RA)/400))
                SA = match.result == "Won" ? 1 : 0
                expected_score += EA
                actual_score += SA
            end
            k_factor = 800 / (player.matches_played + length(player.doubles_results[last_tournament_id].matches))
            updatedRankings[player.id] = player.rankings["Elo"] + k_factor*(actual_score-expected_score)
        else
            # If player didn't participate in tournament, their ranking doesn't change
            updatedRankings[player.id] = player.rankings["Elo"];
        end
    end
    map(player -> player.rankings[ranking_scheme_to_update] = updatedRankings[player.id], players)
    return nothing
end


"""
    function search_elo_ranking(
        player_id::Int64, 
        players::Vector{Player}
    )::Float64 

Search for a player's current Elo Ranking

Arguments
=========
- `player_id`:
    the player whose ranking is under search.
- `players`:
    an array of players in the simulation.
"""

function search_elo_ranking(
    player_id::Int64, 
    players::Vector{Player}
)::Float64 
    player_ranking = filter(p -> p.id == player_id, players)[1].rankings["Elo"]
    return player_ranking
end