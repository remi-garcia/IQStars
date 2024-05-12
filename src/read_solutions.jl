using Images
using ImageDraw

function solutionstr_to_image(solution::String)
    width_between_circles = 100
    height_between_circles = sqrt(7500) # sqrt(width_between_circles^2-(width_between_circles/2)^2)
    circle_radius = width_between_circles/2 - 0.1*width_between_circles/2
    positions_to_coords = Vector{Tuple{Float64, Float64}}()
    push!(positions_to_coords, (width_between_circles/2,width_between_circles/2))
    for _ in 2:7
        push!(positions_to_coords, (positions_to_coords[end][1]+width_between_circles,positions_to_coords[end][2]))
    end
    push!(positions_to_coords, (width_between_circles,positions_to_coords[end][2]+height_between_circles))
    for _ in 2:6
        push!(positions_to_coords, (positions_to_coords[end][1]+width_between_circles,positions_to_coords[end][2]))
    end
    push!(positions_to_coords, (width_between_circles/2,positions_to_coords[end][2]+height_between_circles))
    for _ in 2:7
        push!(positions_to_coords, (positions_to_coords[end][1]+width_between_circles,positions_to_coords[end][2]))
    end
    push!(positions_to_coords, (width_between_circles,positions_to_coords[end][2]+height_between_circles))
    for _ in 2:6
        push!(positions_to_coords, (positions_to_coords[end][1]+width_between_circles,positions_to_coords[end][2]))
    end

    pieces_color = Vector{Tuple{Float64,Float64,Float64}}([
        (0.0,0.0,1.0),
        (0.0,0.8,0.5),
        (1.0,1.0,0.0),
        (1.0,0.0,0.0),
        (1.0,0.0,1.0),
        (1.0,0.5,0.0),
        (0.5,0.0,1.0),
    ])

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

    positions = [position_blue, position_green, position_yellow, position_red, position_pink, position_orange, position_purple]
    img = fill(RGBA(1.0,1.0,1.0,0.0), (round(Int, 3*height_between_circles+width_between_circles), round(Int, 7*width_between_circles)));
    for i in 1:7
        for position in positions[i]
            draw!(img, Ellipse(CirclePointRadius(round(Int, positions_to_coords[position][1]), round(Int, positions_to_coords[position][2]), circle_radius)), RGBA(pieces_color[i][1],pieces_color[i][2],pieces_color[i][3],1))
        end
    end
    return img
end


function save_img_solutions(filename::String)
    solutions::Vector{String} = split(read(filename, String), "\n----------\n")
    for i in 1:(length(solutions)-1)
        img = solutionstr_to_image(solutions[i])
        save("$(@__DIR__)/../solutions/solution_$i.png", img)
    end
    return nothing
end


function solution_to_vector(solution::String)
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

    solution_vector = zeros(Int, 26)
    positions = [position_blue, position_green, position_yellow, position_red, position_pink, position_orange, position_purple]
    for i in 1:7
        for position in positions[i]
            solution_vector[position] = i
        end
    end
    return solution_vector
end


function is_there_a_god(filename::String)
    solutions::Vector{String} = split(read(filename, String), "\n----------\n")
    solutions_vectors = Vector{Vector{Int}}()
    for solution in solutions[1:(end-1)]
        push!(solutions_vectors, solution_to_vector(solution))
    end
    for i in 1:7
        for position in 1:26
            if sum((solution_vector[position] == i ? 1 : 0) for solution_vector in solutions_vectors) == 1
                return true
            end
        end
    end

    return false
end
