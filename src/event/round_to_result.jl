"""
    function round_to_result(
        round::Int64
    )::String

Returns the result corresponding to a round

Arguments
=========
- `round`:
    the round within a tournament.
"""

function round_to_result(
    round::Int64
)::String
    if round == 1
        return "Winner"
    elseif round == 2
        return "Finals"
    elseif round == 4
        return "Semi-Finals"
    elseif round == 8
        return "Quarter-Finals"
    elseif round == 16
        return "Round-16"
    elseif round == 32
        return "Round-32"
    elseif round == 64
        return "Round-64"
    elseif round == 128
        return "Round-128"
    else
        return "Qualified"
    end
end