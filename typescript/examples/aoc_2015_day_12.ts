import fs = require("fs")
import process = require("process")

class JSAbacusFramework {
    constructor(private inputFile:string) {

    }

    private getInput():object{
        return JSON.parse(fs.readFileSync(this.inputFile, "UTF-8"))
    }

    public solvePart1(inp:any):number{
        var sum = 0

        var sumAll = function(o:any):number{
            
            if (o instanceof Array) {
                var s = 0
                for (var i = 0; i < (<Array<any>>o).length; i++){
                    s += sumAll((<Array<any>>o)[i])
                }
                return s
            }
            
            if (!isNaN(o)){
                return o as number
            }
            if (o instanceof Object){
                var s = 0
                Object.keys(o).forEach(function(el, key, _o){
                    var value = o[el]
                    s += sumAll(value)
                })
                return s
            }
            return 0
        }

        return sumAll(inp)
    }

    public solvePart2(inp:any):number{
        var sum = 0

        var sumAll = function(o:any):number{
            
            if (o instanceof Array) {
                var s = 0
                for (var i = 0; i < (<Array<any>>o).length; i++){
                    s += sumAll((<Array<any>>o)[i])
                }
                return s
            }
            
            if (!isNaN(o)){
                return o as number
            }
            if (o instanceof Object){
                var s = 0
                var hasRed = false
                Object.keys(o).forEach(function(el, key, _o){
                    var value = o[el]
                    if (value == "red"){
                        hasRed = true
                    }
                    if (hasRed) {
                        return
                    }
                    s += sumAll(value)
                })
                if (hasRed) {
                    return 0
                }
                return s
            }
            return 0
        }

        return sumAll(inp)
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


var inpf = process.argv[2]
var inpObj = JSON.parse(fs.readFileSync(inpf, "UTF-8"))

var jsa = new JSAbacusFramework(inpf)

assert(jsa.solvePart1([1,2,3]), 6)
assert(jsa.solvePart1({"a":2,"b":4}), 6)
assert(jsa.solvePart1([[[3]]]), 3)
assert(jsa.solvePart1({"a":{"b":4},"c":-1}), 3)
assert(jsa.solvePart1({"a":[-1,1]}), 0)
assert(jsa.solvePart1([-1,{"a":1}]), 0)
assert(jsa.solvePart1([]), 0)
assert(jsa.solvePart1({}), 0)

assert(jsa.solvePart1(inpObj), 191164)

// part 2 - ignore objects/arays that contain "red"

assert(jsa.solvePart2([1,2,3]), 6)
assert(jsa.solvePart2([1,{"c":"red","b":2},3]), 4)
assert(jsa.solvePart2({"d":"red","e":[1,2,3,4],"f":5}), 0)
assert(jsa.solvePart2([1,"red",5]), 6)

assert(jsa.solvePart2(inpObj), 87842)