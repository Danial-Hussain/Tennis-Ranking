"""
    function save_plot(;
        y_var::Vector{Float64},
        title::String,
        f_name::String,
        xlabel::String,
        ylabel::String,
        tournaments::Vector{Tournament}
    )

Creates a plot.

Arguments
=========
- `y_var`:
    y variable.
- `title`:
    plot title.
- `f_name`:
    name of plot file.
- `xlabel`:
    x variable label.
- `ylabel`:
    y variable label.
- `tournaments`:
    tournaments played.
"""

function save_plot(;
    y_var::Vector{Float64},
    title::String,
    f_name::String,
    xlabel::String,
    ylabel::String,
    tournaments::Vector{Tournament}
)
    tournament_types = permutedims(map(t -> t.type, tournaments))
    plot(
        y_var, 
        title=title, 
        seriestype=:scatter,
        xlabel=xlabel,
        ylabel=ylabel,
        labels=tournament_types,
        titlefont=font(10,"Computer Modern"),
        yguidefont=font(8,"Computer Modern"),
        xguidefont=font(8,"Computer Modern"),
    )
    savefig("result/$f_name.png")
end