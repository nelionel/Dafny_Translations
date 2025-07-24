function factorial(num: int): int
    requires num >= 0
    decreases num
{
    if num <= 1 then 1
    else num * factorial(num - 1)
}

method special_factorial(n: int) returns (result: int)
    ensures n <= 0 ==> result == 1
    ensures result >= 1
{
    if n <= 0 {
        result := 1;
    } else {
        result := 1;
        var i := 1;
        while i <= n
            invariant 1 <= i <= n + 1
            invariant result >= 1
        {
            result := result * factorial(i);
            i := i + 1;
        }
    }
}