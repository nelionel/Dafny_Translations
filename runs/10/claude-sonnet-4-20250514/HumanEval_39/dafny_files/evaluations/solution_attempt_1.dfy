predicate is_prime(num: int)
{
    if num < 2 then false
    else if num == 2 then true
    else if num % 2 == 0 then false
    else is_prime_odd(num, 3)
}

predicate is_prime_odd(num: int, i: int)
    requires num >= 3
    requires i >= 3
    requires i % 2 == 1
    decreases if i * i > num then 0 else num - i * i
{
    if i * i > num then true
    else if num % i == 0 then false
    else is_prime_odd(num, i + 2)
}

predicate is_fibonacci(num: int)
{
    if num == 0 || num == 1 then true
    else is_fibonacci_helper(num, 0, 1)
}

predicate is_fibonacci_helper(target: int, a: int, b: int)
    requires a >= 0 && b >= 0
    requires target >= 0
    decreases if b > target then 0 else target - b
{
    if b == target then true
    else if b > target then false
    else is_fibonacci_helper(target, b, a + b)
}

method prime_fib(n: int) returns (result: int)
    requires n >= 1
    ensures result >= 2
    ensures is_prime(result)
    ensures is_fibonacci(result)
{
    var count := 0;
    var a, b := 0, 1;
    
    while count < n
        invariant 0 <= count <= n
        invariant a >= 0 && b >= 1
        decreases n - count
    {
        var fib_num := a;
        
        if is_prime(fib_num) {
            count := count + 1;
            if count == n {
                result := fib_num;
                return;
            }
        }
        
        // Generate next Fibonacci number
        var temp := a + b;
        a := b;
        b := temp;
    }
    
    // This should never be reached due to the loop condition
    result := 2;
}