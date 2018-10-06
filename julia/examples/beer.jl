function bottles_of_beer()
    bottles = 99

    while bottles >= 0
        if bottles > 0
            println("$(bottles) bottle$(bottles == 1 ? "" : "s") of beer on the wall, $(bottles) bottle$(bottles == 1 ? "" : "s") of beer.")
            if bottles - 1 > 0
                println("Take one down, pass it around, $(bottles - 1) bottle$((bottles-1) == 1 ? "" : "s") of beer on the wall.")
            else
                println("Take one down, pass it around, no more bottles of beer on the wall.")
            end
        else
            println("No more bottles of beer on the wall, no more bottles of beer.")
            println("Go to the store and buy some more, 99 bottles of beer on the wall.")
        end
        bottles-=1
    end
end

bottles_of_beer()