from strutils import split, parseInt
from algorithm import sort, reverse
import  system

proc read_spreadsheet(filename:string):seq[seq[int]] =
    var retval:seq[seq[int]] = @[]
    
    var file = open(filename)


    for line in file.lines:
        var row: seq[int] = @[]
        for val in split(line, '\t'):
            var n = parseInt(val)
            row.add(n)
        retval.add(row)
    
    file.close()

    return retval


proc calculate_checksum(matrix:seq[seq[int]]):int = 
    var s = 0
    for row in matrix:
        s += max(row) - min(row)
    return s


proc get_divisible(row:var openArray[int]):(int, int) =
    sort(row, system.cmp)
    reverse(row)
    for i in countup(0, len(row)-2):
        for j in countup(i+1, len(row)-1):
            if row[j] != 0 and (row[i] mod row[j]) == 0:
                return (row[i], row[j])
    return (0, 0)

proc complicated_checksum(matrix:seq[seq[int]]):int = 
    var s = 0
    for row in matrix:
        var r = row
        var (n,k) = get_divisible(r)
        if k != 0:
            s += (n div k)
    return s

var matrix = read_spreadsheet("aoc_2017_day2_input")

echo "Part1: Checksum: ", calculate_checksum(matrix)
echo "Part2: Checksum: ", complicated_checksum(matrix)