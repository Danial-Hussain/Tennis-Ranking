include("../src/simulation.jl")
using .TennisRanking

# Test Run for Simulation

simulation(
    player_count = 700,
    seasons = 1,
    number_of_replications = 1,
    burn_in_seasons = 1,
    ranking_schemes = Vector{String}(["ATP"]),
    metrics = Vector{String}(["Spearman Correlation"]),
    verbose = true,
    strength_method = "BT"
)