class Bottles {
    private bottles: number;

    constructor(public numberOfBottles: number){
        this.bottles = numberOfBottles
    }

    takeOneDown():void {
        if (this.bottles == 0) {
            return
        }
        this.bottles--;
    }

    howManyOnTheWall():string{
        var bottles = this.bottles ? `${this.bottles}` : "no more"
        return `${bottles[0].toUpperCase() + bottles.substring(1)} bottles of beer on the wall, ${bottles} bottles of beer.`
    }

    howManyLeft():string{
        if (this.bottles == 0) {
            return "Go to the store and buy some more, 99 bottles of beer on the wall."
        }
        var bottles = this.bottles-1 ? `${this.bottles-1}` : "no more"
        return `Take one down and pass it around, ${bottles} bottles of beer on the wall.`
    }

    drink():void{
        var totalBottles = this.bottles
        for (var i = 0; i <= totalBottles; i++){
            console.log(this.howManyOnTheWall())
            console.log(this.howManyLeft())
            this.takeOneDown()
        }
    }
}

var bottles = new Bottles(99)
bottles.drink()