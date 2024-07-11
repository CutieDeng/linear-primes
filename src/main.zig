const std = @import("std");

const lib = @import("root.zig"); 

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){}; 
    const allocator = gpa.allocator(); 
    defer _ = gpa.deinit(); 
    const million = try allocator.alloc(u64, 100000000);  
    defer allocator.free(million); 
    const min = try allocator.alloc(u64, 100000000);  
    defer allocator.free(min); 
    @memset(min, 0); 

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Get all primes less than 10,000,000\n", .{}); 
    const prime_nums = lib.getPrimes(million, min, 0); 
    for (million[0..prime_nums], 0..) |v, i| {
        try stdout.print("{}:{}\n", .{ i, v }); 
    }
    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
