# Input format:
#position blue: {4,5,6,12}
#position green: {11,18,25,26}
#position yellow: {7,13,19,20}
#position red: {16,17,23,24}
#position pink: {8,14,21,22}
#position orange: {9,10,15}
#position purple: 1..3
function change_solution_format(solution::String)
    position_blue_str, position_green_str, position_yellow_str, position_red_str,
        position_pink_str, position_orange_str, position_purple_str = split(solution, "\n")
    position_blue = parse.(Int, split(position_blue_str[(findfirst(isequal('{'), position_blue_str)+1):(findfirst(isequal('}'), position_blue_str)-1)], ","))
    position_green = parse.(Int, split(position_green_str[(findfirst(isequal('{'), position_green_str)+1):(findfirst(isequal('}'), position_green_str)-1)], ","))
    position_yellow = parse.(Int, split(position_yellow_str[(findfirst(isequal('{'), position_yellow_str)+1):(findfirst(isequal('}'), position_yellow_str)-1)], ","))
    position_red = parse.(Int, split(position_red_str[(findfirst(isequal('{'), position_red_str)+1):(findfirst(isequal('}'), position_red_str)-1)], ","))
    position_pink = parse.(Int, split(position_pink_str[(findfirst(isequal('{'), position_pink_str)+1):(findfirst(isequal('}'), position_pink_str)-1)], ","))
    position_orange = parse.(Int, split(position_orange_str[(findfirst(isequal('{'), position_orange_str)+1):(findfirst(isequal('}'), position_orange_str)-1)], ","))
    position_purple = Vector{Int}()
    if occursin('{', position_purple_str)
        position_purple = parse.(Int, split(position_purple_str[(findfirst(isequal('{'), position_purple_str)+1):(findfirst(isequal('}'), position_purple_str)-1)], ","))
    else
        last_purple_position = parse.(Int, split(position_purple_str, ".")[end])
        position_purple = collect((last_purple_position-2):last_purple_position)
    end

    # position_blue = 7
    # position_green = 2
    # position_yellow = 3
    # position_red = 5
    # position_pink = 4
    # position_orange = 6
    # position_purple = 1

    new_solution = ""
    for i in 1:26
        if i in position_blue
            new_solution *= "7"
        elseif i in position_green
            new_solution *= "2"
        elseif i in position_yellow
            new_solution *= "3"
        elseif i in position_red
            new_solution *= "5"
        elseif i in position_pink
            new_solution *= "4"
        elseif i in position_orange
            new_solution *= "6"
        elseif i in position_purple
            new_solution *= "1"
        else
            error("Error in solution")
        end
        if i == 7
            new_solution *= "\n "
        elseif i == 13
            new_solution *= "\n"
        elseif i == 20
            new_solution *= "\n "
        elseif i != 26
            new_solution *= " "
        end
    end

    return new_solution
end

function change_solutions_file_format(file::String, new_file::String)
    solutions::Vector{String} = split(read((@__DIR__)*"/"*file, String), "\n----------\n")
    open((@__DIR__)*"/"*new_file, "w") do io
        for solution in solutions[1:(end-1)]
            write(io, change_solution_format(solution))
            write(io, "\n----------\n")
        end
        write(io, solutions[end])
    end

    return nothing
end
