"""
    function correlation(;
        players::Array{Player},
        ranking_scheme1::String,
        ranking_scheme2::String
    )::Float64

Calculates the correlation between two metrics.

Arguments
=========
- `players`:
    the players whose rankings to consider.
- `ranking_scheme1`:
    ranking scheme 1 to use.
- `ranking_scheme2`:
    ranking scheme 2 to use.
"""

function correlation(;
    players::Array{Player},
    ranking_scheme1::String,
    ranking_scheme2::String
)::Float64
    rankings1 = map(player -> player.rankings[ranking_scheme1], players)
    rankings2 = map(player -> player.rankings[ranking_scheme2], players)
    return cor(rankings1, rankings2)
end