# run it with bash:
#   seq 99 -1 0 | awk -f beers.awk
BEGIN {}
/^0$/ {print "No more bottles of beer on the wall. No more bottles of beer.\nGo to the store and buy some more. 99 bottles of beer on the wall.\n"}
/^1$/ {print "1 bottle of beer on the wall. 1 bottle of beer.\nTake it down, pass it around, no more bottles of beer on the wall.\n"}
/^([2-9])$/ { print $1 " bottles of beer on the wall." $1 " bottles of beer.\nTake one down, pass it around, " $1-1 " bottles of beer on the wall.\n"}
/^([0-9]{2})$/ { print $1 " bottles of beer on the wall." $1 " bottles of beer.\nTake one down, pass it around, " $1-1 " bottles of beer on the wall.\n"}
END {}