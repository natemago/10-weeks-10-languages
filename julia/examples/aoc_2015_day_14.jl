
function load_input(file_name::String)::Dict
    raindeers = Dict()
    open(file_name) do f 
        for line in eachline(f)
            m = match(r"(?P<raindeer>\w+) can fly (?P<speed>\d+) km/s for (?P<flight>\d+) seconds, but then must rest for (?P<rest>\d+) seconds.", line)
            if m != Nothing
                raindeers[m["raindeer"]] = (raindeer=m["raindeer"], speed=parse(Int64, m["speed"]), flight=parse(Int64, m["flight"]), rest=parse(Int64, m["rest"]))
            else
                throw(ErrorException("Line did not match: $(line)"))
            end
        end
    end
    return raindeers
end


function calculate_distance(n::Int64, raindeer)
    cycle_time = raindeer.flight + raindeer.rest
    cycles = div(n, cycle_time)
    r = mod(n, cycle_time)
    dist = cycles*raindeer.speed*raindeer.flight

    if r != 0
        if r <= raindeer.flight
            dist += r*raindeer.speed
        else
            dist += raindeer.flight * raindeer.speed
        end
    end

    return dist
end


function part1_winner(t::Int64, raindeers::Dict)::Int64
    return maximum([calculate_distance(t, raindeer) for (_, raindeer) in raindeers])
end


function part2_new_scoring_system(t::Int64, raindeers::Dict)::Int64
    scoreboard = Dict()

    for i in 1:t
        state = Dict()
        for (rn, raindeer) in raindeers
            dist = calculate_distance(i, raindeer)
            if !haskey(state, dist)
                state[dist] = []
            end
            state[dist] = push!(state[dist], rn)
        end
        for rn in state[maximum([d for (d,_) in state])]
            if !haskey(scoreboard, rn)
                scoreboard[rn] = 0
            end
            scoreboard[rn] += 1
        end
    end

    return maximum([score for (_, score) in scoreboard])
end





inp = load_input("aoc_2015_day_14_input")

# Some tests for part 1

raindeers = Dict(
    "Comet" => (speed=14, flight=10, rest=127, raindeer="Comet"),
    "Dancer" =>(speed=16, flight=11, rest=162, raindeer="Dancer")
)

@assert part1_winner(1000, raindeers) == 1120 "Comet should be in the lead with 1120km."
println(" Part 1 tests passed.")

# Now solve part 1

@assert part1_winner(2503, inp) == 2696 "The solution for this input should be 2696."
println(" Part 1 solution passed.")

# Part 2, test

@assert part2_new_scoring_system(1000, raindeers) == 689 "Dancer should have 689 points."
println(" Part 2 tests passed.")

# Solve part 2

@assert part2_new_scoring_system(2503, inp) == 1084 "The winned should have 1084 points."
println(" Part 2 solution passed.")