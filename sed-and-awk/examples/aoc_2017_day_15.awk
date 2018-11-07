# run with:
#   echo "" | awk -f aoc_2017_day_15.awk
BEGIN {
    # test data
    # genA = 65;
    # genB = 8921;
    genA = 634
    genB = 301
    count = 0

    # part 1
    for (i = 0; i < 40000000; i++) {
        genA = (genA * 16807) % 2147483647
        genB = (genB * 48271) % 2147483647
        if (and(genA, 0xFFFF) == and(genB, 0xFFFF)) {
            count += 1
        }
        
    }

    # part 2
    genA1 = 634
    genB1 = 301
    count1 = 0
    pair_count = 0

    for (i = 0; i < 5000000; i++ ){
        while(1){
            genA1 = (genA1 * 16807) % 2147483647
            if ((genA1%4) == 0) {
                break;
            }
        }
        while(1){
            genB1 = (genB1 * 48271) % 2147483647
            if ((genB1%8) == 0) {
                break;
            }
        }
        if (and(genA1, 0xFFFF) == and(genB1, 0xFFFF)) {
            count1 += 1
        }
    }
}
END {
    print "Part 1: " count " pairs."
    print "Part 2: " count1 " pairs."

}