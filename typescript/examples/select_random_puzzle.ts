import fs = require("fs")
import process = require("process")
import readline = require("readline")

function randInt(n:number):number{
    return Math.floor(Math.random()*n)
}

class SelectRandomPuzzle {
    private storage:string
    private data:object

    constructor(private storagePath:string) {
        this.storage = storagePath
    }

    public load():void{
        if (!fs.existsSync(this.storage)){
            fs.writeFileSync(this.storage, "{}")
        }
        var content = fs.readFileSync(this.storage, "UTF-8")
        this.data = JSON.parse(content)
    }

    public save():void {
        fs.writeFileSync(this.storage, JSON.stringify(this.data))
    }

    public selectPuzzle():void{
        var puzzle = this.generateRandomPuzzle()
        if (puzzle === undefined) {
            console.info("You have chosen all puzzles.")
            return
        }
        const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout
        })

        rl.question(`Your puzzle is year ${puzzle["year"]}, puzzle number ${puzzle["puzzle"] + 1}. Accept? [type 'y' or 'yes' to accept]: `, (answer) => {
            if (answer == 'y' || answer == 'yes'){
                if (!this.data['puzzles']){
                    this.data['puzzles'] = []
                }
                this.data['puzzles'].push(puzzle)
                this.save()
                rl.close()
                console.info('Good luck!')
                return
            }
            rl.close()
            console.warn("You haven't accepted the selected puzzle.")
        })
    }

    private generateRandomPuzzle():object {
        var years = [2015, 2016, 2017]
        var count = 0
        var selected = this.data['selected'] || []
        while (count < 24*3) {
            var randYear = years[randInt(3)]
            var randPuzzle = randInt(24) // the 25th puzzle is usually very convoluted or dependent on others
            
            for(var i = 0; i < selected.length; i++){
                if (selected['year'] == randYear && selected['puzzle'] == randPuzzle) {
                    count++
                    continue
                }
            }

            return {
                "year":randYear,
                "puzzle": randPuzzle
            }
        }
        return undefined
    }
}

if (process.argv.indexOf("-h") > 0 || process.argv.indexOf("--help") > 0){
    console.info("Usage: node select_random_puzzle.js <storage_file>")
    process.exit(0)
}
var storage:string = "selected.json"
if (process.argv.length > 2) {
    storage = process.argv[2]
}

var selectPuzzle = new SelectRandomPuzzle(storage)

selectPuzzle.load()
selectPuzzle.selectPuzzle()

