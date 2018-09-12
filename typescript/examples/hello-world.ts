for (let i = 0; i <=99; i++){
    let bottlesNow = 99 - i + ""
    let bottlesLeft = 99 - i - 1 + ""
    if (i >= 98) {
        bottlesLeft = "no more"
    }
    if (i == 99 ) {
        bottlesNow = "no more"
    }
    console.log(bottlesNow[0].toUpperCase() + bottlesNow.substring(1) + " bottles of beer on the wall, " + bottlesNow + " bottles of beer.")
    if (i == 99){
        console.log("Go to the store and buy some more, 99 bottles of beer on the wall.")
    }else{
        console.log("Take one down and pass it around, " + bottlesLeft + " bottles of beer on the wall.")
    }
    console.log()
}