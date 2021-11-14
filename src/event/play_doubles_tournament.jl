"""
    function play_doubles_tournament(;
        tournament::Tournament, 
        players::Vector{Player},
        ranking_scheme::String
    )

Simulates the results of a doubles tennis tournament.
This function will remove the results, for each player, of the
same tournament that was played last season. If the player didn't
play this tournament last year, nothing will be removed.

Arguments
=========
- `tournament`:
    a specific tournament to simulate.
- `players`
    a player pool to select tournament participants from.
- `ranking_scheme`
    the ranking scheme being updated and used for seeding.
"""

function play_doubles_tournament(;
    tournament::Tournament, 
    players::Vector{Player},
    ranking_scheme::String
)
    # Sort the players by the ranking scheme under consideration
    sort!(players, by = p -> p.rankings[ranking_scheme], alg=InsertionSort)
    # Remove the results from this tournament played in the previous years
    map(player -> delete!(player.doubles_results, tournament.id), players)

    # Participants needed for the tournament
    playersLeft = tournament.drawsize * 2
    participants = Vector{Player}([])
    index = 1

    # Add players to a tournament
    while playersLeft > 0 && index <= length(players)
        if rand() <= participationProbability(players[index], tournament)
            players[index].tournaments_played += 1
            push!(participants, players[index])
            playersLeft -= 1;
        end
        index += 1
    end

    # Check if there aren't enough players
    if playersLeft > 0
        throw(DomainError(length(players), "not enough players for this tournament"))
    end

    # Form teams from the players
    teams = form_teams("Next Best Player", players, ranking_scheme)
    sort!(teams, by = t -> t.ranking, alg=InsertionSort)

    # Generate bracket
    bracket = generate_bracket(teams, tournament.drawsize)

    # Execute bracket
    winning_team = execute_bracket(bracket, tournament, 2)

    # Update the winning team's doubles tournament summary
    winning_team.player1.doubles_results[tournament.id].result = round_to_result(1)
    winning_team.player2.doubles_results[tournament.id].result = round_to_result(1)

    return nothing
end