function get_all_possible_positions(piece::Vector{Int}, starting_pos::Int)
    possible_positions = Vector{Vector{Int}}()
    for current_rotation in 0:5
        current_position = Vector{Int}()
        not_possible = false
        previous_star_position = starting_pos
        for star in piece
            star_rotation_wrt_previous_star = (star + current_rotation) % 6
            star_position = 0
            if star_rotation_wrt_previous_star == 0
                star_position = previous_star_position + 1
                if star_position in [8,14,21,27]
                    not_possible = true
                end
            elseif star_rotation_wrt_previous_star == 1
                star_position = previous_star_position + 7
                if star_position > 26 || star_position == 14
                    not_possible = true
                end
            elseif star_rotation_wrt_previous_star == 2
                star_position = previous_star_position + 6
                if star_position > 26 || star_position in [7,20]
                    not_possible = true
                end
            elseif star_rotation_wrt_previous_star == 3
                star_position = previous_star_position - 1
                if star_position in [0,7,13,20]
                    not_possible = true
                end
            elseif star_rotation_wrt_previous_star == 4
                star_position = previous_star_position - 7
                if star_position < 1 || star_position == 7
                    not_possible = true
                end
            elseif star_rotation_wrt_previous_star == 5
                star_position = previous_star_position - 6
                if star_position < 1 || star_position in [1,14]
                    not_possible = true
                end
            end
            push!(current_position, star_position)
            previous_star_position = star_position
        end
        if !not_possible
            push!(possible_positions, copy(current_position))
        end
    end

    return possible_positions
end


function get_pieces()
    return [
    [0,1,5], # blue
    [0,0,5], # green
    [1,5,0], # yellow
    [0,2,0], # red
    [0,1,2], # pink
    [0,1], # orange
    [0,0], # purple
    ]
end

function get_pieces_with_name()
    return [
    "blue" => [0,1,5],
    "green" => [0,0,5],
    "yellow" => [1,5,0],
    "red" => [0,2,0],
    "pink" => [0,1,2],
    "orange" => [0,1],
    "purple" => [0,0],
    ]
end




function generate_data()
    pieces = get_pieces_with_name()
    data = ""

    for (name, piece) in pieces
        n = 0
        data *= "array[1..tobedefined,1..$(length(piece)+1)] of int: positions_$name =\n"
        data *= "array2d(1..tobedefined,1..$(length(piece)+1)),\n["
        for position in 1:26
            possible_positions = get_all_possible_positions(piece, position)
            for i in 1:length(possible_positions)
                n += 1
                data *= "$position"
                for j in possible_positions[i]
                    data *= ",$j"
                end
                if i != length(possible_positions) || position != 26
                    data *= ","
                end
                data *= "\n"
            end
        end
        data *= "]);\n"
        data = replace(data, "tobedefined"=>"$n")
    end

    println(data)

    return data
end


function generate_data()
    pieces = get_pieces_with_name()
    data = ""

    for (name, piece) in pieces
        n = 0
        data *= "array[1..tobedefined] of set of int: positions_$name =\n"
        data *= "["
        for position in 1:26
            possible_positions = get_all_possible_positions(piece, position)
            for i in 1:length(possible_positions)
                n += 1
                data *= "{$position"
                for j in possible_positions[i]
                    data *= ",$j"
                end
                if i != length(possible_positions) || position != 26
                    data *= "},"
                else
                    data *= "}"
                end
                data *= "\n"
            end
        end
        data *= "];\n"
        data = replace(data, "tobedefined"=>"$n")
    end

    println(data)

    return data
end
