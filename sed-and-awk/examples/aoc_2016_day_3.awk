# Run it:
#   echo input | awk -f aoc_2016_day_3.awk
BEGIN {
    possible_triangles = 0
    vtriangles = 0
    line = 0
}
/([0-9]+)[ \t]+([0-9]+)[ \t]+([0-9]+)/ {
    a = $1
    b = $2
    c = $3
    if ( ((a + b) > c) && ((a + c) > b) && ((b + c) > a)){
        possible_triangles++
    }
    rows[line, 0] = a
    rows[line, 1] = b
    rows[line, 2] = c
    if ((line + 1) % 3 == 0) {
        for (i = 0; i < 3; i++){
            a = rows[line, i]
            b = rows[line - 1, i]
            c = rows[line - 2, i]
            if ( ((a + b) > c) && ((a + c) > b) && ((b + c) > a)){
                vtriangles++
            }
        }
    }
    line++
}
END {
    print "Part 1: " possible_triangles " possible triangles."
    print "Part 2: " vtriangles " possible triangles."
}