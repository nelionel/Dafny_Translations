predicate is_prime(num: int)
{
    if num < 2 then false
    else if num == 2 then true
    else if num % 2 == 0 then false
    else has_no_odd_divisors(num, 3)
}

predicate has_no_odd_divisors(num: int, divisor: int)
    requires num >= 3
    requires divisor >= 3
    requires divisor % 2 == 1
    decreases if divisor * divisor <= num then num - divisor else 0
{
    if divisor * divisor > num then true
    else if num % divisor == 0 then false
    else has_no_odd_divisors(num, divisor + 2)
}

method x_or_y(n: int, x: int, y: int) returns (result: int)
    ensures result == if is_prime(n) then x else y
{
    if is_prime(n) {
        result := x;
    } else {
        result := y;
    }
}