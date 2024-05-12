include("$(@__DIR__)/read_solutions.jl")

function get_all_possible_positions(piece::Vector{Int}, starting_pos::Int)
    possible_positions = Vector{Set{Int}}()
    for current_rotation in 0:5
        current_position = Set{Int}()
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



function generate_data()
    pieces = Dict{String, Vector{Int}}([
        "blue" => [0,1,5],
        "green" => [0,0,5],
        "yellow" => [1,5,0],
        "red" => [0,2,0],
        "pink" => [0,1,2],
        "orange" => [0,1],
        "purple" => [0,0],
    ])
    data = ""

    for (name, piece) in pieces
        possible_positions = Vector{Set{Int}}()
        for position in 1:26
            current_possible_positions = get_all_possible_positions(piece, position)
            push!.(current_possible_positions, position)
            append!(possible_positions, current_possible_positions)
        end
        unique!(possible_positions)
        data *= "array[1..$(length(possible_positions))] of set of int: positions_$name =\n["
        for i in 1:length(possible_positions)
            vec_possible_positions = collect(possible_positions[i])
            data *= "{$(vec_possible_positions[1])"
            for j in vec_possible_positions[2:end]
                data *= ",$j"
            end
            if i != length(possible_positions)
                data *= "},"
            else
                data *= "}"
            end
            data *= "\n"
        end
        data *= "];\n\n"
    end

    filename = "$(@__DIR__)/iqstars.mzn"
    open(filename, "w") do f
        write(f, data)
        write(f, """
        int: nb_pieces = 7;
        % positions_blue, positions_green, positions_yellow, positions_red, positions_pink, positions_orange, positions_purple

        array[1..nb_pieces] of var int: piece_position;

        constraint {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26} subset (positions_blue[piece_position[1]] union positions_green[piece_position[2]] union positions_yellow[piece_position[3]] union positions_red[piece_position[4]] union positions_pink[piece_position[5]] union positions_orange[piece_position[6]] union positions_purple[piece_position[7]]);

        solve satisfy;

        output[
        "position blue: \\(positions_blue[piece_position[1]])\\n",
        "position green: \\(positions_green[piece_position[2]])\\n",
        "position yellow: \\(positions_yellow[piece_position[3]])\\n",
        "position red: \\(positions_red[piece_position[4]])\\n",
        "position pink: \\(positions_pink[piece_position[5]])\\n",
        "position orange: \\(positions_orange[piece_position[6]])\\n",
        "position purple: \\(positions_purple[piece_position[7]])"
        ];
        """)
    end

    return nothing
end


function solving_iqstarsmzn()
    run(`minizinc --all-solutions --solver Chuffed --output-to-file $(@__DIR__)/iqstars_solutions.txt $(@__DIR__)/iqstars.mzn`)
    return nothing
end


function main()
    generate_data()
    solving_iqstarsmzn()
    rm("$(@__DIR__)/iqstars.mzn")
    save_img_solutions("$(@__DIR__)/iqstars_solutions.txt")

    println("Is there a god problem?")
    println(is_there_a_god("$(@__DIR__)/iqstars_solutions.txt"))
    return nothing
end
