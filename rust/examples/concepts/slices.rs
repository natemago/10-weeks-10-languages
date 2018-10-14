fn main(){
    let slice:[i32; 3] = [1,2,3];
    let ref_to_slice:&[i32] = &slice; // works ok

    let produced = produce_vec(10); // produce a vec with capacity of 10 i32 elems.

    let my = MyType{  // put this struct on the stack
        value: 10,
        another_value: 20
    };

    let mut my_boxed = Box::new(MyType{ // allocate the struct on heap
        value: 10,
        another_value: 20
    });
}

fn produce_vec(size:usize) -> Vec<i32>{
    let result:Vec<i32> = Vec::with_capacity(size);
    result
}

struct MyType {
    value:i32,
    another_value:i32
}