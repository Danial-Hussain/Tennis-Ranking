module Metric

import Dates
using Dates
using StatsBase
using Plots

using ..Types

export correlation
export calculate_metric
export save_plot

include("correlation.jl")
include("calculate_metric.jl")
include("save_plot.jl")

end