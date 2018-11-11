from strutils import capitalizeAscii

proc bottles(n:int):string =
    if n == 0:
        return "no more bottles"
    elif n == 1:
        return "1 bottle"
    return $n & " bottles"

for i in countdown(99, 0):
    var btls = bottles(i)
    var take_one = bottles(i-1)
    
    echo capitalizeAscii(btls), " of beer on the wall, ", btls, " of beer."
    if i > 0:
        echo "Take one down, pass it around, ", take_one, " of beer on the wall.\n"
    else:
        echo "Go to the store and get some more. 99 bottles of beer on the wall.\n"