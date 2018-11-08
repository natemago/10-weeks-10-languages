99 Beers in Awk
===============

Run it:

```
seq 99 -1 0 | awk -f beers.awk
```

Awk: AoC 2017, day 15 
=====================

Solution for [AoC 2017, Day 15](https://adventofcode.com/2017/day/15):

```
echo "" | awk -f aoc_2017_day_15.awk
```

Awk: AoC 2016, Day 3
====================

Solution for [AoC 2016, Day 3](https://adventofcode.com/2016/day/3):

```
cat input_2016_day_3 | awk -f aoc_2016_day_3.awk
```

Sed: 99 beers
=============

I won't be solving any full challenges with Sed, but it might come in handy when pre-procesisng 
imput for Awk.

Here's 99-beers program in Sed:

```bash
seq 99 -1 0 | \
    sed -E -e 's/^0+$/No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and get some more, 99 bottles of beer on the wall.\n/' \
        -e 's/^1+$/1 bottle of beer on the wall, 1 bottle of beer.\nTake it down, pass it around, no more bottles of beer on the wall.\n/' \
        -e 's/^([0-9]+)+$/echo "\1 bottles of beer on the wall, \1 bottles of beers.\nTake one down, pass it around, $((\1-1)) bottles of beer on the wall.\n"/e'
```