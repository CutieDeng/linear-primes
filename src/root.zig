const std = @import("std");
const testing = std.testing;

export fn add(a: i32, b: i32) i32 {
    return a + b;
}

test "basic add functionality" {
    try testing.expect(add(3, 7) == 10);
}

pub fn getPrimes(primes: []u64, min_factor: []u64, prime_index: usize) usize {
    var count: usize = 0; 
    var p: u64 = if (prime_index == 0) 2 else ( primes[prime_index - 1] + 1 ); 
    var pidx: usize = prime_index; 
    while (true) {
        if (p >= min_factor.len) break; 
        if (min_factor[p - 2] == 0 or min_factor[p - 2] == p) {
            min_factor[p - 2] = p; 
            primes[pidx] = p; 
            pidx += 1; 
            count += 1; 
            if (pidx >= primes.len) break; 
        }  
        var j: usize = 0; 
        const my_min = min_factor[p - 2]; 
        while (true) { 
            if (j >= pidx) break; 
            const other_prime = primes[j]; 
            if (other_prime > my_min) break; 
            const m = @mulWithOverflow(p, other_prime); 
            if (m.@"1" == 1) break;  
            const v = m.@"0"; 
            if (v - 2 >= min_factor.len) break; 
            min_factor[v-2] = other_prime; 
            j += 1; 
        }
        p += 1; 
    }
    return count; 
}