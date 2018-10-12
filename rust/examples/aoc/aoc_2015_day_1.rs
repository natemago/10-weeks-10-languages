use std::fs::File;
use std::io::prelude::*;

fn main(){
    let mut f = File::open("aoc_2015_day_1_input").expect("file not found");
    let mut content = String::new();

    f.read_to_string(&mut content).expect("failed reading input");

    let mut floor = 0;
    let mut first_basement_idx = 0;

    for (i, c) in content.chars().enumerate(){
        if c == '(' {
            floor+=1;
        }else if c== ')'{
            floor-=1;
        }
        if floor < 0 && first_basement_idx == 0{
            first_basement_idx = i+1;
        }
    }

    println!("Part 1: Final floor: {}", floor);
    println!("Part 2: Hits basement at: {}", first_basement_idx);
}