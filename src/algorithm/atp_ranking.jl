"""
    function atp_ranking(
        players::Vector{Player},
        ranking_scheme_to_update::String
    )

Update the player's rankings using ATP Ranking system.

Arguments
=========
- `players`:
    an array of players in the simulation.
- `ranking_scheme_to_update`:
    the name of the ranking scheme to update for each Player.
"""

function atp_ranking(
    players::Vector{Player}, 
    ranking_scheme_to_update::String
)
    ordered_ranking = []
    for player in players
        point_total = 0
        top6_results = Vector{Int64}([])
        for (tournament_name, summary) in player.doubles_results
            if summary.tournament_type == "Grandslam" ||
               summary.tournament_type == "ATP1000"
                point_total +=
                    compute_points(summary.result, summary.tournament_type)
            else
                push!(
                    top6_results,
                    compute_points(summary.result, summary.tournament_type),
                )
            end
        end
        sort!(top6_results, rev = true)
        point_total += sum(top6_results[1:min(length(top6_results), 6)])
        player.rankings[ranking_scheme_to_update] = point_total
    end
    return nothing
end


"""
    function compute_points(
        result::String,
        tournament_type::String
    )::Int64

Retrieve the number of points corresponding to a player's performance in a tournament.

Arguments
=========
- `result`:
    the final round that a player finished in a tournament.
- `tournament_type`:
    the type of the tournament. Ex: Grandslam
"""

function compute_points(
    result::String, 
    tournament_type::String
)::Int64
    if tournament_type == "Grandslam"
        return ATPGrandSlamDoublesPoints[result]
    elseif tournament_type == "ATPNitto"
        return ATPNittoFinalsPoints[result]
    elseif tournament_type == "ATP1000"
        return ATP1000DoublesPoints[result]
    elseif tournament_type == "ATP500"
        return ATP500DoublesPoints[result]
    elseif tournament_type == "ATP250"
        return ATP250DoublesPoints[result]
    elseif tournament_type == "ATPChallenger125"
        return ATPChallengerTour125DoublesPoints[result]
    elseif tournament_type == "ATPChallenger110"
        return ATPChallengerTour110DoublesPoints[result]
    elseif tournament_type == "ATPChallenger100"
        return ATPChallengerTour100DoublesPoints[result]
    elseif tournament_type == "ATPChallenger90"
        return ATPChallengerTour90DoublesPoints[result]
    elseif tournament_type == "ATPChallenger80"
        return ATPChallengerTour80DoublesPoints[result]
    elseif tournament_type == "ITFWorldTennisTour25k"
        return ITFWorldTennisTour25kPoints[result]
    elseif tournament_type == "ITFWorldTennisTour15k"
        return ITFWorldTennisTour15kPoints[result]
    end
    return throw(DomainError(tournament_type, "invalid tournament type"))
end
