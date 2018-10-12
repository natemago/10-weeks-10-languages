fn main(){
    // immutable type
    let i = 10;
    // i = i+1; // compile error

    println!("i is {}", i);
    let mut b = 10;
    b = b+1; // works just fine

    println!("but b now is {}", b);

    // let pi = &i;
    // *pi = *pi+1; // compile error: cannot borrow as mutable!

}