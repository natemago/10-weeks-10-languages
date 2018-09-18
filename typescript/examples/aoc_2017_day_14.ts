
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


class Defragmenter{
    private grid:string[][];
    private hashes:string[];

    constructor(private keyString:string){

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

