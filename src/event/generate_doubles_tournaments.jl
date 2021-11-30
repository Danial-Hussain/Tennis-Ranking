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
                ),Tournament(
                    name = "Roland Garros",
                    date = Date(2018, 5, 27),
                    type = "Grandslam",
                    drawsize = 64
                ),Tournament(
                    name = "Wimbledon",
                    date = Date(2018, 7, 2),
                    type = "Grandslam",
                    drawsize = 64
                ),Tournament(
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
                    date = Date(2018, 3, 9),
                    type = "ATP1000",
                    drawsize = 32
                ),Tournament(
                    name = "Miami Open",
                    date = Date(2018, 3, 23),
                    type = "ATP1000",
                    drawsize = 32
                ),Tournament(
                    name = "Monte-Carlo Masters",
                    date = Date(2018, 4, 13),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),Tournament(
                    name = "Madrid Open",
                    date = Date(2018, 5, 4),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),Tournament(
                    name = "Italian Open",
                    date = Date(2018, 5, 11),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),Tournament(
                    name = "Canadian Open",
                    date = Date(2018, 8, 10),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),Tournament(
                    name = "Cincinnati Masters",
                    date = Date(2018, 8, 17),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),Tournament(
                    name = "Shanghai Masters",
                    date = Date(2018, 10, 12),
                    type = "ATP1000",
                    drawsize = 32 # not accurate | reality - 24
                ),Tournament(
                    name = "Paris Masters",
                    date = Date(2018, 11, 2),
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
                    date = Date(2018, 2, 9),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Rio Open",
                    date = Date(2018, 2, 16),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Dubai Tennis Championships",
                    date = Date(2018, 2, 23),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Mexican Open",
                    date = Date(2018, 2, 23),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Barcelona Open",
                    date = Date(2018, 4, 20),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Queen's Club Championships",
                    date = Date(2018, 6, 15),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Halle Open",
                    date = Date(2018, 6, 15),
                    type = "ATP500",
                    drawsize = 32
                ),Tournament(
                    name = "German Open",
                    date = Date(2018, 7, 27),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Washington Open",
                    date = Date(2018, 8, 3),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "China Open",
                    date = Date(2018, 10, 5),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Japan Open",
                    date = Date(2018, 10, 5),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Vienna Open",
                    date = Date(2018, 10, 19),
                    type = "ATP500",
                    drawsize = 16
                ),Tournament(
                    name = "Swiss Indoors",
                    date = Date(2018, 10, 26),
                    type = "ATP500",
                    drawsize = 16
                ),
            ]
        )
    end

    if ATP250 == true
        append!(
            tournaments,
            [
                Tournament(
                    name = "Brisbane International",
                    date = Date(2018, 1, 5),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Maharashtra Open",
                    date = Date(2018, 1, 5),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Qatar Open",
                    date = Date(2018, 1, 5),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Auckland Open",
                    date = Date(2018, 1, 12),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Sydney International",
                    date = Date(2018, 1, 12),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Open Sud de France",
                    date = Date(2018, 2, 2),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Brasil Open",
                    date = Date(2018, 2, 9),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Delray Beach Open",
                    date = Date(2018, 2, 16),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Open 13",
                    date = Date(2018, 2, 16),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Argentina Open",
                    date = Date(2018, 2, 23),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Grand Prix Hassan II",
                    date = Date(2018, 4, 6),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "US Men's Clay Court Championship",
                    date = Date(2018, 4, 6),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Bavaria Open",
                    date = Date(2018, 4, 27),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Estoril Open",
                    date = Date(2018, 4, 27),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Geneva Open",
                    date = Date(2018, 5, 19),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Rosmalen Open",
                    date = Date(2018, 6, 8),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Stuttgart Open",
                    date = Date(2018, 6, 8),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Eastbourne International",
                    date = Date(2018, 6, 21),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Mallorca Open",
                    date = Date(2018, 6, 19),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Hall of Fame Open",
                    date = Date(2018, 7, 13),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Swedish Open",
                    date = Date(2018, 7, 20),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Croatia Open",
                    date = Date(2018, 7, 20),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Atlanta Open",
                    date = Date(2018, 7, 27),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Swiss Open",
                    date = Date(2018, 7, 27),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Austrian Open",
                    date = Date(2018, 8, 3),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Winston-Salem Open",
                    date = Date(2018, 8, 24),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Moselle Open",
                    date = Date(2018, 9, 21),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Shenzhen Open",
                    date = Date(2018, 9, 24),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Stockholm Open",
                    date = Date(2018, 10, 19),
                    type = "ATP250",
                    drawsize = 16
                ),Tournament(
                    name = "Kremlin Cup",
                    date = Date(2018, 10, 19),
                    type = "ATP250",
                    drawsize = 16
                )
            ]
        )
    end

    if ATPChallenger == true
        append!(
            tournaments,
            map((index) -> Tournament(
                name = "Challenger125 $index",
                date = Date(2018, 1, 1),
                type = "ATPChallenger125",
                drawsize = 32
                ), 1:25)
        )
        append!(
            tournaments,
            map((index) -> Tournament(
                name = "Challenger110 $index",
                date = Date(2018, 1, 1),
                type = "ATPChallenger110",
                drawsize = 32
                ), 1:12)
        )
        append!(
            tournaments,
            map((index) -> Tournament(
                name = "Challenger100 $index",
                date = Date(2018, 1, 1),
                type = "ATPChallenger100",
                drawsize = 32
                ), 1:19)
        )
        append!(
            tournaments,
            map((index) -> Tournament(
                name = "Challenger90 $index",
                date = Date(2018, 1, 1),
                type = "ATPChallenger90",
                drawsize = 32
                ), 1:91)
        )
    end

    if ITFWorldTennisTour == true
        append!(
            tournaments,
            map((index) -> Tournament(
                name = "ITF $index",
                date = Date(2018, 1, 1),
                type = "ITFWorldTennisTour25k",
                drawsize = 32
            ), 1:550)
        )
    end
    
    return tournaments
end