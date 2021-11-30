# Tennis Ranking Simulation

> A tennis season simulation for evaluating various ranking algorithms.

## Usage

> How to configure requirements and run the simulation.

**Requirements**

Packages used in this project can be referenced from the `Project.toml` file.

**Run Simulation**

```julia

include("../src/simulation.jl")
using .TennisRanking

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
```

**Options**

```
Arguments
=========
- `player_count`:
    the number of players to create.
- `seasons`:
    the number of seasons to simulate.
- `number_of_replications`:
    the number of times to repeat the simulation.
- `burn_in_seasons`:
    the number of burn in seasons to use.
- `ranking_schemes`:
    which ranking algorithms to test.
    options:
        1) "ATP"
        2) "Elo"
        3) "Dwz"
- `metrics`:
    the metrics to be evaluated during the simulation.
    options:
        1) Spearman Correlation
        2) Kendall Tau Correlation
- `verbose`:
    whether to print each stage of the simulation.
    options:
        1) true
        2) false
- `strength_method`:
    method to determine the probability team 1 beats team 2.
    options:
        1) "BT" - Bradley Terry Model
        2) "BT_Exp" - Bradley Terry Exponential Model
```
