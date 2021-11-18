"""
    function spearman_corr(;
        players::Array{Player},
        ranking_scheme1::String,
        ranking_scheme2::String
    )::Float64

Calculates the Spearman Correlation between two ranks.

Arguments
=========
- `players`:
    the players whose rankings to consider.
- `ranking_scheme1`:
    ranking scheme 1 to use.
- `ranking_scheme2`:
    ranking scheme 2 to use.
"""

function spearman_corr(;
    players::Array{Player},
    ranking_scheme1::String,
    ranking_scheme2::String
)::Float64
    rankings1 = map(player -> player.rankings[ranking_scheme1], players)
    rankings2 = map(player -> player.rankings[ranking_scheme2], players)
    return corspearman(rankings1, rankings2)
end


"""
    function kendtau_corr(;
        players::Array{Player},
        ranking_scheme1::String,
        ranking_scheme2::String
    )::Float64

Calculates the Kendall Tau Correlation between two ranks.

Arguments
=========
- `players`:
    the players whose rankings to consider.
- `ranking_scheme1`:
    ranking scheme 1 to use.
- `ranking_scheme2`:
    ranking scheme 2 to use.
"""

function kendtau_corr(;
    players::Array{Player},
    ranking_scheme1::String,
    ranking_scheme2::String
)::Float64
    rankings1 = map(player -> player.rankings[ranking_scheme1], players)
    rankings2 = map(player -> player.rankings[ranking_scheme2], players)
    return corkendall(rankings1, rankings2)
end