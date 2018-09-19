
class List {
    private elements:number[];

    constructor(public size:number=255){
        this.elements = []
        for(var i = 0; i < this.size; i++){
            this.elements.push(i)
        }
    }

    public sublist(start:number, offset:number):number[]{
        start = start%this.size
        var subl: number[] = []
        if (start + offset < this.size){
            return subl.concat(this.elements.slice(start, start+offset))
        }
        subl = subl.concat(this.elements.slice(start))
        return subl.concat(this.elements.slice(0, (start+offset)-this.size))
    }

    public reverseSlice(start:number, offset:number):void{
        var slice = this.sublist(start, offset)
        slice.reverse()
        // now apply it
        for (var i = 0; i < slice.length; i++){
            var idx = (start+i)%this.size
            this.elements[idx] = slice[i]
        }
    }

    public at(i:number):number{
        return this.elements[i]
    }

    public toString():string {
        return "[" + this.elements.join(",") + "]"
    }
}


/**
 * This implements the Knot Hash of AoC 2017, day 10 and is needed
 * to implement the disk defragmenter.
 */
class KnotHash {
    private list:List
    private pos:number
    private skipSize:number
    static HEX:string = "0123456789abcdef"
    private hashSize:number

    constructor(public value:string, hashSize:number=256){
        this.list = new List(hashSize)
        this.pos = 0
        this.skipSize = 0
        this.hashSize = hashSize
    }

    public iterate(size:number):void{
        this.list.reverseSlice(this.pos, size)
        this.pos = (this.pos + size + this.skipSize)%this.hashSize
        this.skipSize++
    }

    public digest():string{
        var keyVals:number[] = []
        for(var i = 0; i < this.value.length; i++){
            keyVals.push(this.value.charCodeAt(i))
        }

        keyVals = keyVals.concat([17, 31, 73, 47, 23])
        var rounds = 64
        while(rounds){
            for(var i = 0; i < keyVals.length; i++){
                this.iterate(keyVals[i])
            }
            rounds--
        }

        var denseHash:number[] = []
        for (var i = 0; i < 16; i++){
            let hash = 0
            for (var j = 0; j < 16; j++){
                hash ^= this.list.at(i*16 + j)
            }
            denseHash.push(hash)
        }

        var hash = ""
        denseHash.forEach(function(val:number, idx:number, a:number[]){
            hash += KnotHash.HEX[(val&0xF0)>>4] + KnotHash.HEX[val&0xF]
        })

        return hash
    }
}


function bitsToString(hashStr:string, zero:string=".", one:string="#"):string[]{
    var bitsRepr = []

    for (var i = 0; i < hashStr.length; i+=2){
        let v = parseInt(hashStr.slice(i, i+2), 16)
        let mask = 0x80
        for (var j = 0; j < 8; j++ ){
            if(v&mask){
                bitsRepr.push(one)
            }else{
                bitsRepr.push(zero)
            }
            mask >>= 1
        }
    }

    return bitsRepr
}

class Defragmenter{
    private grid:string[][];
    private hashes:string[];

    constructor(private keyString:string){
        this.hashes = []
        this.grid = []
        this.generateGrid()
    }

    private getGridSize():Object{
        var rows = this.grid.length
        var cols =  rows > 0 ? this.grid[0].length : 0
        return {
            'rows': rows,
            'cols': cols
        }
    }

    private generateGrid():void{
        for (var i = 0; i < 128; i++){
            let idxKey = `${this.keyString}-${i}`
            let hash = new KnotHash(idxKey).digest()
            this.hashes.push(hash)
            this.grid.push(bitsToString(hash))
        }
    }

    public drawGrid(maxRow:number=-1, maxCol:number=-1):void{
        let gridSize  =this.getGridSize()
        if (maxRow < 0 || maxRow > gridSize['rows'] ){
            maxRow = gridSize['rows']
        }
        if (maxCol < 0 || maxCol > gridSize['cols']) {
            maxCol = gridSize['cols']
        }
        for (var i = 0; i < maxCol; i++){
            console.log(this.grid[i].slice(0, maxRow).join(''))
        }
    }

    public countOnes():number{
        let count = 0
        let cols = this.getGridSize()['cols']
        let rows = this.getGridSize()['rows']
        for(var i = 0; i < cols; i++){
            for (var j = 0; j < rows; j++){
                if (this.grid[j][i] != '.'){
                    count++
                }
            }
        }
        return count
    }

    public countContigiousRegions():number{
        var grid = this.grid
        var gridSize = this.getGridSize()
        var key = function(col,row:number):string{
            return `${col}-${row}`
        }
        var getAvailableCells = function(col:number, row:number, visited:Object):number[][]{
            var available:number[][] = []
            if(row > 0 && !visited[key(col, row-1)]){
                available.push([col, row-1])
            }
            if (row < gridSize['rows'] -1 && !visited[key(col, row+1)]){
                available.push([col, row+1])
            }
            if(col > 0 && !visited[key(col-1, row)]){
                available.push([col-1, row])
            }
            if(col < gridSize['cols']-1 && !visited[key(col+1, row)]){
                available.push([col+1, row])
            }
            return available
        }
        
        
        var markAll = function(col,row,curr:number, visited:Object):void{
            if(visited[key(col,row)]){
                return
            }
            visited[key(col, row)] = true
            if(grid[row][col] == '.'){
                return
            }
            grid[row][col] = `${curr}`
            var available = getAvailableCells(col,row, visited)
            available.forEach(function(pos){
                if(grid[pos[1]][pos[0]] == '#'){
                    markAll(pos[0], pos[1], curr, visited)
                }
            })
        }

        var visited = {}
        var count = 0
        for(var i = 0; i < gridSize['rows']; i++){
            for(var j = 0; j < gridSize['cols']; j++){
                if(grid[i][j] == '#'){
                    count++
                    markAll(j, i, count, visited)
                }
            }
        }

        return count
    }

}

function assert(val:any, expected:any, message?:string){
    if(val != expected){
        var msg = `Expected: ${expected}, but got ${val}.`
        if (message){
            msg = message + " " + msg
        }
        throw new Error(msg)
    }
}

// test the know hash

assert(new KnotHash("").digest(), "a2582a3a0e66e6e86e3812dcb672a272")
assert(new KnotHash("AoC 2017").digest(), "33efeb34ea91902bb2f59c9920caa6cd")
assert(new KnotHash("1,2,3").digest(), "3efbe78a8d82f29979031a4aa0b16a9d")
assert(new KnotHash("1,2,4").digest(), "63960835bcdc130f0b66d7ff4f6a5a8e")


var def = new Defragmenter("flqrgnkx")
var contRegions = def.countContigiousRegions()
def.drawGrid(8,8)
console.log('Continious regions:', contRegions)
assert(contRegions, 1242)

assert(def.countOnes(), 8108)
console.log('✓ Test OK')

def = new Defragmenter('jzgqcdpd')
def.drawGrid(8,8)
assert(def.countOnes(), 8074)
console.log('✓ Part 1 OK')

assert(def.countContigiousRegions(), 1212)
console.log('✓ Part 2 OK')