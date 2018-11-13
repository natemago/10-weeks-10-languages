import sequtils
from algorithm import reverse
from strutils import toHex, toLower, toBin
# knot hash
proc knot(lengths:seq[int], size:int, rounds:int=1):seq[int] =
    var list:seq[int] = @[]
    for i in countup(0, size-1):
        list.add(i)
    
    var pos = 0
    var skip = 0

    for r in countup(1, rounds):
        for n in lengths:
            let s = pos mod size
            let e = pos + n - 1
            var ss:seq[int]
            if e < size:
                ss = toSeq list[s..e]
            else:
                ss = (toSeq list[s..size-1])
                ss.add(toSeq list[0..(e mod size)])
            reverse(ss)
            for i in countup(0, len(ss)-1):
                list[(pos+i) mod size] = ss[i]
            
            pos = (pos + n + skip) mod size
            skip += 1
        #echo list, "; pos=", pos, "; ss=", ss, "; skip=", skip, "; n=", n
    return list

# # Day 10 (Knot Hash), part 1 - unlock part for knot_hash alg.
# var result = knot(@[120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113], 256)
# echo result[0]*result[1] # result 826

proc knot_hash(data:string):seq[int] =
    var input:seq[int] = @[]
    var hash:seq[int] = @[]
    for c in data:
        input.add(int(c))
    
    # add magic numbers
    input.add(@[17, 31, 73, 47, 23])

    var result = knot(input, 256, 64)
    
    for i in countup(0, 15):
        var hash_val = 0
        for j in countup(0, 15):
            hash_val = hash_val xor result[i*16 + j]
        hash.add(hash_val)
    
    return hash

proc knot_hash_str(data:string):string =
    var result = ""
    let hash = knot_hash(data)
    for hv in hash:
        result.add(toLower(toHex(hv, 2)))
    return result


# KnotHash - part 2
# echo knot_hash_str("120,93,0,90,5,80,129,74,1,165,204,255,254,2,50,113")
# result: d067d3f14d07e09c2e7308c3926605c4

################################################
# Day 14

proc generate_grid(input:string):seq[seq[int]] = 
    var result:seq[seq[int]] = @[]
    
    for i in countup(0, 127):
        var label = ""
        label.add(input)
        label.add("-")
        label.add(i)
        var row:seq[int] = @[]

        let hash = knot_hash(label)
        for j in countup(0, 15):
            let hv = hash[j]
            for v in @[(hv and 0xF0) shr 4, (hv and 0x0F)]:
                for c in toBin(v, 4):
                    if c == '1':
                        row.add(1)
                    else:
                        row.add(0)
        result.add(row)
    return result

proc count_taken(grid:seq[seq[int]]):int =
    var count = 0
    for row in grid:
        for c in row:
            count += c
    return count

proc grid_to_str(grid:seq[seq[int]], c:int=0, r:int=0):string =
    var s = ""
    var rc:int = 0
    var cc:int = 0
    for row in grid:
        cc = 0
        for c in row:
            if c == 1:
                s.add("#")
            else:
                s.add(".")
            cc += 1
            if c > 0 and cc >= c:
                break
        s.add("\n")
        rc += 1
        if r > 0 and rc >= r:
            break
    return s

proc mark(grid:var seq[seq[int]], x,y:int, group:int):bool =
    var marked = false
    if grid[y][x] == 1:
        grid[y][x] = group
        marked = true
    else:
        # marked or 0
        return false
    
    # check up
    if y > 0:
        marked = mark(grid, x, y - 1, group) or marked
    
    # check down
    if y < len(grid) - 1:
        marked = mark(grid, x, y + 1, group) or marked
    
    # check left
    if x > 0:
        marked = mark(grid, x - 1, y, group) or marked

    # check right
    if x < len(grid[0]) - 1:
        marked = mark(grid, x + 1, y, group) or marked

    return marked


proc count_regions(grid: seq[seq[int]]):int =
    var vgrid = grid
    var regions = 0
    for y in countup(0, len(grid)-1):
        for x in countup(0, len(grid[y])-1):
            if mark(vgrid, x,y, regions+100):
                regions+=1
    return regions


echo "Part 1: ", count_taken(generate_grid("ugkiagan"))
echo "Part 2: ", count_regions(generate_grid("ugkiagan"))
