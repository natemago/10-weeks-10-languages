(define (sing-beers beers)
    (cond 
        ((= 0 beers) (display "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n\n")) 
        ((= 1 beers) (display "1 more bottle of beer on the wall, 1 more bottle of beer.\nTake it down, pass it around, no more bottles of beer on the wall.\n\n"))
        (else (for-each display (list  beers " bottles of beer on the wall, " beers " bottles of beer.\nTake one down, pass it around, " (- beers 1) " bottles of beer on the wall.\n\n"))))
    
    (if (> beers 0) (sing-beers (- beers 1)))
)

(sing-beers 99)
