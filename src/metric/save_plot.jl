"""
    function save_plot(;
        x_var::Vector{Any},
        y_var::Vector{Any},
        title::String,
        f_name::String
    )

Creates a plot.

Arguments
=========
- `x_var`:
    x variable.
- `y_var`:
    y variable.
- `title`:
    plot title.
- `f_name`:
    name of plot file.
"""

function save_plot(;
    x_var::Vector{Int64},
    y_var::Vector{Float64},
    title::String,
    f_name::String
)
    plot(x_var, y_var, title=title, lw=3)
    savefig("$f_name.png")
end