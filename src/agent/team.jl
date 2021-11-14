"""
    function strength(
        team::Team,
        method::String
    )::Float64

Calculates the combined strength of a team.

Arguments
=========
- `team`:
    a team of players.
- `method`
    the method for calculating team strength
        current methods include:
            - "Simple Average" 
                assigns strength to be average of individual player strengths.
            - "Weighted Average"
"""

function strength(team::Team, method::String)::Float64
    if method == "Simple Average"
        p1_strength = strength(team.player1)
        p2_strength = strength(team.player2)
        return (p1_strength + p2_strength) / 2.0
    else
        throw(DomainError(method, "this method isn't supported"))
    end
end

"""
    function probabilityOfWinning(
        team1::Team,
        team2::Team
    )::Float64

Calculates the probability of team1 beating team2.

Arguments
=========
- `team1`:
    the team for whose probability is calculated.
- `team2`
    the opposing team.
"""

function probabilityOfWinning(team1::Team, team2::Team)::Float64
    team1_strength = strength(team1, "Simple Average")
    team2_strength = strength(team2, "Simple Average")
    if team1_strength > team2_strength
        return 0.8
    else
        return 0.2
    end
end
