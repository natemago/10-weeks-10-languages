
/**
 * append the value at position ```pos``` and grow the vec.
 * result = input[1..pos-1] + [pos] + input[pos..]
 */
fn append(slice: Vec<u64>, pos:u64, value:u64) -> Vec<u64>{
    let mut result:Vec<u64> = Vec::with_capacity(slice.len() + 1);
    for i in 0..slice.len() {
        let mut v = slice[i];
        if (i as u64) == pos {
            result.push(value);
        }
        result.push(v);
    }
    return result;
}

/**
 * Part 1: Calculate the value that is right next to the final insert in the spinlock bufffer.
 */
fn spinlock_last_value(step_size:u64, steps:usize) -> u64 {
    let mut p:u64 = 0;
    let mut buff = Vec::new();
    let mut result = 0;
    buff.push(0);
    for i in 0..steps {
        let buff_size = (i + 1) as u64;
        p = (p + step_size + 1)%buff_size;
        buff = append(buff, p, buff_size);
        if i == (steps-1) {
            let after = (p+1)%buff_size;
            result = buff[after as usize];
        }
    }
    return result;
}


fn spinlock_first_hit_at_position_0(step_size:u64, steps:usize) -> u64 {
    let mut p:u64 = 0;
    let mut result:u64 = 0; // value after 0

    let mut i:u64 = 0;
    while i < (steps as u64) {
        let value = i+1;
        p = (p + step_size + 1) % value;
        
        if p == 0 {
            result = value;
        }

        i += 1;
    }
    result
}

fn main(){
    assert!(spinlock_last_value(3, 2017) == 638, "Expected to be 638.");
    println!("Part 1 test passes.");
    assert!(spinlock_last_value(303, 2017) == 1971, "Expected part 1 to be 1971.");
    println!("Part 1 passes.");

    assert!(spinlock_first_hit_at_position_0(303, 50_000_000) == 17_202_899, "Expected Part 2 to be 17 202 899.");
    println!("Part 2 passes.")
}