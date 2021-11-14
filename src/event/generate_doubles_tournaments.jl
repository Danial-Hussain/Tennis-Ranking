"""
    function generate_doubles_tournaments(
        Grandslam::Bool = true,
        ATPNitto::Bool = true,
        ATP1000::Bool = true,
        ATP500::Bool = true,
        ATP250::Bool = true,
        ATPChallenger::Bool = true,
        ITFWorldTennisTour::Bool = true
    )::Vector{Tournament}

Generates an array of tournaments in a twelve month season.

Arguments
=========
- `Grandslam`:
    whether or not to include Grandslam tournaments.
- `ATPNitto`
    whether or not to include the ATP Nitto tournament.
- `ATP1000`
    whether or not to include the ATP 1000 tournament.
- `ATP500`
    whether or not to include the ATP 500 tournament.
- `ATP250`
    whether or not to include the ATP 250 tournament.
- `ATPChallenger`
    whether or not to include the ATP Challenger tournament.
- `ITFWorldTennisTour`
    whether or not to include the ITF World Tennis Tour.
"""

function generate_doubles_tournaments(
    Grandslam::Bool = true,
    ATPNitto::Bool = true,
    ATP1000::Bool = true,
    ATP500::Bool = true,
    ATP250::Bool = true,
    ATPChallenger::Bool = true,
    ITFWorldTennisTour::Bool = true
)::Vector{Tournament}
    tournaments = Vector{Tournament}([])

    if ATPNitto == true 
        append!(
            tournaments,
            [
                Tournament(
                    name = "Nitto Finals",
                    date = Date(2018, 11, 11),
                    type = "ATPNitto",
                    drawsize = 8
                )
            ]
        )
    end

    if Grandslam == true
        append!(
            tournaments,
            [
                Tournament(
                    name = "Australian Open",
                    date = Date(2018, 1, 15),
                    type = "Grandslam",
                    drawsize = 64
                ),
                Tournament(
                    name = "Roland Garros",
                    date = Date(2018, 5, 27),
                    type = "Grandslam",
                    drawsize = 64
                ),
                Tournament(
                    name = "Wimbledon",
                    date = Date(2018, 7, 2),
                    type = "Grandslam",
                    drawsize = 64
                ),
                Tournament(
                    name = "US Open",
                    date = Date(2018, 8, 27),
                    type = "Grandslam",
                    drawsize = 64
                )
            ]
        )
    end

    if ATP1000 == true
        append!(
            tournaments,
            [
                Tournament(
                    name = "Indian Wells Masters",
                    date = Date(2018, 3, 8),
                    type = "ATP1000",
                    drawsize = 32
                ),
                Tournament(
                    name = "Miami Open",
                    date = Date(2018, 3, 21),
                    type = "ATP1000",
                    drawsize = 32
                ),
                Tournament(
                    name = "Monte-Carlo Masters",
                    date = Date(2018, 4, 15),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),
                Tournament(
                    name = "Madrid Open",
                    date = Date(2018, 5, 6),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),
                Tournament(
                    name = "Italian Open",
                    date = Date(2018, 5, 13),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),
                Tournament(
                    name = "Canadian Open",
                    date = Date(2018, 8, 6),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),
                Tournament(
                    name = "Cincinnati Masters",
                    date = Date(2018, 8, 12),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),
                Tournament(
                    name = "Shanghai Masters",
                    date = Date(2018, 10, 7),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),
                Tournament(
                    name = "Paris Masters",
                    date = Date(2018, 10, 29),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                )
            ]
        )
    end

    if ATP500 == true
        append!(
            tournaments,
            [
                Tournament(
                    name = "Rotterdam Open",
                    date = Date(2018, 3, 8),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Rio Open",
                    date = Date(2018, 2, 19),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Dubai Tennis Championships",
                    date = Date(2018, 2, 26),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Mexican Open",
                    date = Date(2018, 2, 26),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Barcelona Open",
                    date = Date(2018, 4, 23),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Queen's Club Championships",
                    date = Date(2018, 3, 8),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Halle Open",
                    date = Date(2018, 6, 18),
                    type = "ATP500",
                    drawsize = 32
                ),
                Tournament(
                    name = "Hamburg European Open",
                    date = Date(2018, 7, 23),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Washington Open",
                    date = Date(2018, 7, 30),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "China Open",
                    date = Date(2018, 10, 1),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Japan Open",
                    date = Date(2018, 10, 1),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Vienna Open",
                    date = Date(2018, 10, 22),
                    type = "ATP500",
                    drawsize = 16
                ),
                Tournament(
                    name = "Swiss Indoors",
                    date = Date(2018, 10, 22),
                    type = "ATP500",
                    drawsize = 16
                ),
            ]
        )
    end

    if ATP250 == true
    end

    if ATPChallenger == true
    end

    if ITFWorldTennisTour == true
    end

    return tournaments
end