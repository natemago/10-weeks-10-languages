Rust
====

Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety.

 * Homepage https://www.rust-lang.org
 * [The Book](https://doc.rust-lang.org/book/)

# Installation and setup

I followed the installation as per the [Archlinux wiki article](https://wiki.archlinux.org/index.php/rust) - using the upstream installation script:

```bash
curl -f https://sh.rustup.rs > rust.sh
# check it out
vim rust.sh
# make it executable and execute it
chmod +x rust.sh
./rust.sh

```

# Features

Very similar to C++ - extremly low level, with fine-grained control over memory (stack/heap).
Remember to add ```;``` when ending expressions (C/C++/Java like style).

**NOTE**: It has a special concepts, called _ownership_ and _lifetimes_. These, together with the _scope_
are used so the compiler would have knowledge of when the memory for a certain variable/allocation can be
released and is no longer used, so it can invalidate it, thus avoiding the need for garbage collector.

Variables are by default immutable, but are not constants.

```rust
// immutable type
let i = 10;
// i = i+1; // compile error

println!("i is {}", i);
let mut b = 10;
b = b+1; // works just fine

println!("but b now is {}", b);

// let pi = &i;
// *pi = *pi+1; // compile error: cannot borrow as mutable!
```

## Slices, Vec, Box

Slices/arrays are very low level, C-like even, so allocating a dynamic array can be difficult.
The size of an array must be known at compile time, so this won't work:

```rust
let slice = [i32, var_lenght]; // gives compile time error.
```

You can use references to a slice, as a function argument for example, and then you don't have to specify the
size of the slice:

```rust
let slice:[i32, 3] = [1,2,3];
let ref_to_slice:&[i32] = slice; // compiles ok
```

### Generate a slice by calling a function

This is not easy or desireable in Rust. First, there would be problems with the lifetime of the returned slice.
Second, you need to have the slice allocated on the Heap, but slices and arrays live on the stack (like in C).

The solution is to use ```Vec<T>```.

```rust
let slice:Vec<i32> = Vec::new(); 
// or, with values:
let slice:Vec<i32> = vec![1,23]; // using macro vec!

```

We can even produce a new slice (Vec), like so:

```rust

fn produce_vec(size:usize) -> Vec<i32>{
    let result:Vec<i32> = Vec::with_capacity(size);
    result
}
```

### Structs

Definition of structs is very straight forward:

```rust
struct MyType {
    value:i32,
    another_value:i32
}
```

To create new struct:

```rust

let my = MyType{
    value: 10,
    another_value: 20
};

```

To allocate the structure on the Heap, you can use ```Box<T>```. This will create so-called "boxed" structure
on the heap:

```rust
let mut my_boxed = Box::new(MyType{ // allocate the struct on heap
        value: 10,
        another_value: 20
    });
```


# AoC

## Event 2015, Day 1 (the very first AoC chanllenge)

Solved:

```bash
# in examples/aoc
rustc aoc_2015_day_1.rs
./aoc_2015_day_1
```

## Event 2017, Day 17

Solved:

```bash
# in examples/aoc
rustc aoc_2017_day_17.rs
./aoc_2017_day_17
```