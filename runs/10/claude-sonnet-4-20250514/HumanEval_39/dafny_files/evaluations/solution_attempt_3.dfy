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

predicate is_prime_fibonacci(num: int)
{
    is_prime(num) && is_fibonacci(num)
}

function count_prime_fibs_up_to(limit: int): int
    requires limit >= 0
{
    count_prime_fibs_helper(limit, 0, 1, 0)
}

function count_prime_fibs_helper(limit: int, a: int, b: int, count: int): int
    requires limit >= 0
    requires a >= 0 && b >= 0
    requires count >= 0
    decreases if a > limit then 0 else limit - a + 1
{
    if a > limit then count
    else if is_prime_fibonacci(a) then count_prime_fibs_helper(limit, b, a + b, count + 1)
    else count_prime_fibs_helper(limit, b, a + b, count)
}

method prime_fib(n: int) returns (result: int)
    requires n >= 1
    ensures result >= 2
    ensures is_prime(result)
    ensures is_fibonacci(result)
    ensures count_prime_fibs_up_to(result - 1) == n - 1
    ensures count_prime_fibs_up_to(result) == n
    ensures forall x :: 0 <= x < result && is_prime_fibonacci(x) ==> 
            count_prime_fibs_up_to(x) < n
{
    var count := 0;
    var a, b := 0, 1;
    
    while count < n
        invariant 0 <= count <= n
        invariant a >= 0 && b >= 1
        invariant count == count_prime_fibs_up_to(a - 1)
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