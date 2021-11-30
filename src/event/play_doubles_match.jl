"""
    function play_doubles_match(
        team1::Team,
        team2::Team,
        tournament::Tournament,
        round::Int64,
        strength_method::String
    )::Team

Simulates a doubles match between two teams.

Arguments
=========
- `team1`:
    a team composed of two players.
- `team2`
    a team composed of two players.
- `tournament`
    the tournament in which this match is taking place.
- `round`
    the current round number of the tournament
- `strength_method`
    the method to use to determine the probability of team 1
    beating team 2.
"""

function play_doubles_match(
    team1::Team,
    team2::Team,
    tournament::Tournament,
    round::Int64,
    strength_method::String
)::Team
    for players in [(team1.player1, team1.player2), (team2.player1, team2.player2)]
        players[1].matches_played += 1
        players[2].matches_played += 1
        if !haskey(players[1].doubles_results, tournament.id)
            players[1].doubles_results[tournament.id] = DoublesTournamentPlayerSummary(
                primary_player_id = players[1].id,
                partner_player_id = players[2].id,
                tournament_name = tournament.name,
                tournament_type = tournament.type,
                result = "",
                matches = Array{DoublesMatchPlayerSummary}([])
            )
        end
        if !haskey(players[2].doubles_results, tournament.id)
            players[2].doubles_results[tournament.id] = DoublesTournamentPlayerSummary(
                primary_player_id = players[2].id,
                partner_player_id = players[1].id,
                tournament_name = tournament.name,
                tournament_type = tournament.type,
                result = "",
                matches = Array{DoublesMatchPlayerSummary}([])
            )
        end
    end

    if rand() <= probabilityOfWinning(team1, team2, strength_method)
        winner = team1        
    else
        winner = team2
    end
    
    for team in [team1, team2]
        if team == winner
            for player in [team.player1, team.player2]
                push!(
                    player.doubles_results[tournament.id].matches,
                    DoublesMatchPlayerSummary(
                        opponent1_player_id = (team1 == winner) ? 
                            team2.player1.id : team1.player1.id,
                        opponent2_player_id = (team1 == winner) ?
                            team2.player2.id : team1.player2.id,
                        result = "Won",
                        score = "6-0, 6-0, 6-0"
                    )
                )
            end
        else
            for player in [team.player1, team.player2]
                push!(
                    player.doubles_results[tournament.id].matches,
                    DoublesMatchPlayerSummary(
                        opponent1_player_id = (team1 == winner) ?
                             team1.player1.id : team2.player1.id,
                        opponent2_player_id = (team1 == winner) ?
                             team1.player2.id : team2.player2.id,
                        result = "Lost",
                        score = "0-6, 0-6, 0-6"
                    )
                )
                player.doubles_results[tournament.id].result = round_to_result(round)
            end
        end
    end    
    return winner
end