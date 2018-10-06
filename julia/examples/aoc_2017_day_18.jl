struct Instruction
    op::String
    arg1::String
    arg2::String
end

mutable struct Queue
    q::Array{Any, 1}
end 

Queue() = Queue([])

function take!(q::Queue)::Any
    if length(q.q) > 0
        v = q.q[1]
        q.q = q.q[2:length(q.q)]
        return v
    end
    return nothing
end

function put!(q::Queue, v::Any)
    q.q = push!(q.q, v)
end

mutable struct Computer 
    id::String
    ops::Dict
    rx::Queue
    tx::Queue
    mem::Array{Instruction,1}
    regs::Dict
    send::String
    recv::String
    pc::Int64
    sendcount::Int64
    iswaiting::Bool
end

function isnumeric(s::String)::Bool
    return match(r"^-?\d+$", s) != nothing
end

function pcincr!(comp::Computer, i::Int64)
    if comp.pc + i > length(comp.mem) || comp.pc + i < 1
        throw(error("HALT: $(comp.id), PC: $(comp.pc), INCR: $(i)"))
    end
    comp.pc = comp.pc + i
end


function getvalue!(cmp::Computer, val::String)::Int64
    if isnumeric(val)
        return parse(Int64, val)
    end
    if haskey(cmp.regs, val)
        return cmp.regs[val]
    end
    cmp.regs[val] = 0
    return 0
end

function NewComputer(id::String, prog::Array{Instruction, 1}, rx::Queue, tx::Queue, part2::Bool=false)::Computer
    regs = Dict()
    ops = Dict(
        "snd" => function(comp::Computer, instr::Instruction)
            val = getvalue!(comp, instr.arg1)
            comp.send = "$val"
            comp.sendcount += 1
            if part2
                println(" ==", comp.id," sends ", val, " sendcount=", comp.sendcount)
                put!(comp.tx, val)
            end
            pcincr!(comp, 1)
        end,
        "set" => function(comp::Computer, instr::Instruction)
            reg = instr.arg1
            val = getvalue!(comp, instr.arg2)
            comp.regs[reg] = val
            pcincr!(comp, 1)
        end,
        "add" => function(comp::Computer, instr::Instruction)
            reg = instr.arg1
            val = getvalue!(comp, instr.arg2)
            comp.regs[reg] = getvalue!(comp, reg) + val
            pcincr!(comp, 1)
        end,
        "mul" => function(comp::Computer, instr::Instruction)
            reg = instr.arg1
            val = getvalue!(comp, instr.arg2)
            comp.regs[reg] = getvalue!(comp, reg) * val
            pcincr!(comp, 1)
        end,
        "mod" => function(comp::Computer, instr::Instruction)
            reg = instr.arg1
            val = getvalue!(comp, instr.arg2)
            comp.regs[reg] =mod(getvalue!(comp, reg), val)
            pcincr!(comp, 1)
        end,
        "rcv" => function(comp::Computer, instr::Instruction)
            val = getvalue!(comp, instr.arg1)
            if val != 0
                comp.recv = comp.send
            end

            if part2
                comp.iswaiting = true
                println(" ==", comp.id, " is receiving...")
                v = take!(comp.rx)
                if v == nothing
                    return
                end
                comp.iswaiting = false
                comp.regs[instr.arg1] = v
                println(" ==", comp.id, " received:", v)
            end
            
            pcincr!(comp, 1)
        end,
        "jgz" => function(comp::Computer, instr::Instruction)
            val = getvalue!(comp, instr.arg1)
            inc = getvalue!(comp, instr.arg2)
            if val > 0
                pcincr!(comp, inc)
            else
                pcincr!(comp, 1)
            end
        end,
    )

    return Computer(id, ops, rx, tx, prog, regs, "", "", 1, 0, false)
end


function runstep!(comp::Computer)
    instr = comp.mem[comp.pc] # fetch
    exec = comp.ops[instr.op] # decode
    exec(comp, instr) # execute
end

function run!(comp::Computer, stopcond)
    while true
        runstep!(comp)
        if stopcond(comp)
            break
        end
    end
end

function parseprog(progspecs::Array{String,1})::Array{Instruction,1}
    instrs::Array{Instruction,1} = []
    for line in progspecs
        parts = split(strip(line), " ")
        op = parts[1]
        arg1 = length(parts) > 1 ? parts[2] : ""
        arg2 = length(parts) > 2 ? parts[3] : ""
        instrs = push!(instrs, Instruction(op, arg1, arg2))
    end
    return instrs
end


function loadprog(progfile::String)::Array{String, 1}
    prog = []

    open(progfile) do f
        for line in eachline(f)
            prog = push!(prog, strip(line))
        end
    end

    return prog
end


testcomp = NewComputer("test", parseprog([
    "set a 1",
    "add a 2",
    "mul a a",
    "mod a 5",
    "snd a",
    "set a 0",
    "rcv a",
    "jgz a -1",
    "set a 1",
    "jgz a -2"
]),Queue(), Queue())

run!(testcomp, comp::Computer -> comp.recv != "" )

println("Test:", testcomp.recv)

prog = parseprog(loadprog("aoc_2017_day_18_input"))

p1comp = NewComputer("part1", prog, Queue(), Queue())

println(" *** Running part 1 ***")

run!(p1comp, comp::Computer -> comp.recv != "" )

println("Part1:", p1comp.recv)

println(" ********************************* ")
println(" *** Part 2")

rx = Queue()
tx = Queue()

t2prog = parseprog([
    "snd 1",
    "snd 2",
    "snd p",
    "rcv a",
    "rcv b",
    "rcv c",
    "rcv d"
])

#prog = t2prog

prog0 = NewComputer("prog-0", prog, rx, tx, true)
prog0.regs["p"] = 0
prog1 = NewComputer("prog-1", prog, tx, rx, true)
prog1.regs["p"] = 1

function stopcond(comp::Computer)::Bool
    return prog0.iswaiting && prog1.iswaiting
end

while true
    runstep!(prog0)
    runstep!(prog1)
    if prog0.iswaiting && prog1.iswaiting
        break
    end
end
println(" =====> ", prog0.sendcount, "   |   ", prog1.sendcount)
println(" Part 2 solution: ", prog1.sendcount)

