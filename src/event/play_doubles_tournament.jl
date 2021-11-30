"""
    function play_doubles_tournament(;
        tournament::Tournament, 
        players::Vector{Player},
        ranking_scheme::String,
        verbose::Bool
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
- `strength_method`
    method used to determine probability team 1 beats team 2.
- `verbose`:
    whether to print the results.
"""

function play_doubles_tournament(;
    tournament::Tournament, 
    players::Vector{Player},
    ranking_scheme::String,
    strength_method::String,
    verbose::Bool
)
    if verbose
        tournament_name = tournament.name
        tournament_type = tournament.type
        println("########")
        println("Playing $tournament_name - $tournament_type")
        println("########")
        println()
    end

    # Sort the players by the ranking scheme under consideration
    sort!(players, by = p -> p.rankings[ranking_scheme], alg=InsertionSort)
    # Remove the results from this tournament played in the previous years
    map(player -> delete!(player.doubles_results, tournament.id), players)

    # Participants needed for the tournament
    playersLeft = tournament.drawsize * 2
    participants = Vector{Player}([])
    seen = Set{Int64}()
    index = 1
    iterations = 0

    # Add players to a tournament
    while playersLeft > 0 && iterations < 5
        while index <= length(players)
            if !(players[index].id in seen) && rand() <= participationProbability(
                player = players[index], 
                tournament = tournament, 
                ranking_scheme = ranking_scheme,
                players = players
            )
                players[index].tournaments_played += 1
                push!(participants, players[index])
                push!(seen, players[index].id)
                playersLeft -= 1;
            end
            index += 1
        end
        iterations += 1
        index = 1
    end

    # Check if there aren't enough players
    if playersLeft > 0
        throw(DomainError(length(players),"$playersLeft more players needed"))
    end

    # Form teams from the players
    sort!(players, by = p -> p.rankings[ranking_scheme], alg=InsertionSort)
    teams = form_teams("Next Best Player", players, ranking_scheme)
    sort!(teams, by = t -> t.ranking, alg=InsertionSort)

    # Generate bracket
    bracket = generate_bracket(teams, tournament.drawsize)

    # Execute bracket
    winning_team = execute_bracket(bracket, tournament, 2, strength_method)

    # Update the winning team's doubles tournament summary
    winning_team.player1.doubles_results[tournament.id].result = round_to_result(1)
    winning_team.player2.doubles_results[tournament.id].result = round_to_result(1)

    if verbose
        tournament_name = tournament.name
        tournament_type = tournament.type
        println("########")
        println("Finished Playing $tournament_name - $tournament_type")
        println("########")
        println()
    end

    return nothing
end