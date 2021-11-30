"""
    function dwz_ranking(
        players::Vector{Player},
        ranking_scheme_to_update::String,
        last_tournament_id::String
    )

Update the players rankings using the Deutsche Wertungszahl Algorithm

Arguments
=========
- `players`:
    an array of players in the simulation.
- `ranking_scheme_to_update`:
    the name of the ranking scheme to update for each Player.
- `last_tournament_id`:
    the last tournament that was completed.
"""

function dwz_ranking(
    players::Vector{Player},
    ranking_scheme_to_update::String,
    last_tournament_id::String
)
    updatedRankings = Dict{Int64, Int64}();
    for player in players
        if haskey(player.doubles_results, last_tournament_id)
            player_ranking = player.rankings["Dwz"]
            teammate_ranking = search_dwz_ranking(player.doubles_results.partner_player_id, players)
            achieved_points = 0
            expected_points = 0
            n = length(player.doubles_results[last_tournament_id])
            for match in player.doubles_results[last_tournament_id].matches
                zA = (player_ranking + teammate_ranking) / 2
                zG = search_dwz_ranking(match.opponent1_player_id, players) + search_dwz_ranking(match.opponent2_player_id, players)
                wE = 1/(1+(10^((zG-zA)/400)))
                wA = match.result == "Won" ? 1 : 0
                achieved_points += wA
                expected_points += wE
            end
            if player.age < 20
                J = 5
            elseif player.age <= 25
                J = 10
            else
                J = 15
            end
            E0 = (player_ranking/1000)^4 + J
            a = player.age <= 20 && achieved_points > expected_points ? player_ranking/2000 : 1
            B = player_ranking < 1300 && achieved_points <= expected_points ? exp((1300-player_ranking)/150)-1 : 0
            E = a * E0 + B
            Zn = player_ranking + (800/(E+n))(achieved_points-expected_points)
            updatedRankings[player.id] = Zn
        else
            # If player didn't participate in tournament, their ranking doesn't change
            updatedRankings[player.id] = player.rankings["Dwz"];
        end
    end
    map(player -> player.rankings[ranking_scheme_to_update] = updatedRankings[player.id], players)
    return nothing
end


"""
    function search_dwz_ranking(
        player_id::Int64, 
        players::Vector{Player}
    )::Float64 

Search for a player's current Dwz Ranking

Arguments
=========
- `player_id`:
    the player whose ranking is under search.
- `players`:
    an array of players in the simulation.
"""

function search_dwz_ranking(
    player_id::Int64, 
    players::Vector{Player}
)::Float64 
    player_ranking = filter(p -> p.id == player_id, players)[1].rankings["Dwz"]
    return player_ranking
end