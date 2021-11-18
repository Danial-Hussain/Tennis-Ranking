"""
    function calculate_metric(;
        metric::String,
        players::Array{Player},
        ranking_scheme1::String,
        ranking_scheme2::String
    )::Float64

Calculates the desired metric.

Arguments
=========
- `metric`:
    the metric to be calculated.
- `players`:
    the players whose rankings to consider.
- `ranking_scheme1`:
    ranking scheme 1 to use.
- `ranking_scheme2`:
    ranking scheme 2 to use.
"""

function calculate_metric(;
    metric::String,
    players::Array{Player},
    ranking_scheme1::String,
    ranking_scheme2::String
)::Float64
    if metric == "Spearman Correlation"
        return spearman_corr(
            players = players,
            ranking_scheme1 = ranking_scheme1,
            ranking_scheme2 = ranking_scheme2
        )
    elseif metric == "Kendall Tau Correlation"
        return kendtau_corr(
            players = players,
            ranking_scheme1 = ranking_scheme1,
            ranking_scheme2 = ranking_scheme2
        )
    end
    throw(DomainError(metric, "this metric isn't supported"))
end