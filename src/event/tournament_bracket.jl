"""
    function generate_bracket(
        teams::Vector{Team},
        drawsize::Int64
    )::Vector{Any}

Generates a tournament bracket.

Arguments
=========
- `teams`:
    a vector of teams participating in the tournament.
- `drawsize`
    tournament draw size.
"""

function generate_bracket(
    teams::Vector{Team},
    drawsize::Int64
)::Vector{Any}
    @assert (drawsize != 0) && (drawsize-1 != 0)
    matches = Int(drawsize / 2)
    bracket = teams
    while matches > 1
        newbracket = Vector{Any}([[] for _ in 1:matches])
        for m in 1:matches
            push!(newbracket[m], bracket[m])
            push!(newbracket[m], bracket[end-m+1])
        end
        matches = Int(matches/2)
        bracket = newbracket
    end
    return bracket
end


"""
    function execute_bracket(
        current_bracket::Union{Vector{Any}, Vector{Team}, Team},
        tournament::Tournament,
        round::Int64
    )::Team

Simulates a tournament bracket.

Arguments
=========
- `current_bracket`:
    a vector of vectors representing the tournament bracket.
- `tournament`:
    the current tournament being played.
- `round`:
    the current round being played.
"""

function execute_bracket(
    current_bracket::Union{Vector{Any}, Vector{Team}, Team},
    tournament::Tournament,
    round::Int64
)::Team
    if isa(current_bracket, Vector) == false
        return current_bracket
    end
    team1 = execute_bracket(current_bracket[1], tournament, round * 2)
    team2 = execute_bracket(current_bracket[2], tournament, round * 2)
    winning_team = play_doubles_match(team1, team2, tournament, round)
    return winning_team
end