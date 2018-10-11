fn bottlesofbeer(i:u64) -> String {
    if i == 0 {
        return String::from("no more bottles of beer")
    }
    if i == 1 {
        return String::from("1 bottle of beer")
    }
    return format!("{} bottles of beer", i)
}

fn getbeer(beers:u64){
    let how_many_beers = bottlesofbeer(beers);
    let upp_how_many_beers = String::from(how_many_beers[0..1].to_uppercase() + &how_many_beers[1..]);
    println!("{} on the wall, {}.",upp_how_many_beers, how_many_beers);
}


fn main() {
    for i in (0..100).rev() {
        getbeer(i);
    }
}
