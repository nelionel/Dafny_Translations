function factorial(num: int): int
    requires num >= 0
    decreases num
{
    if num <= 1 then 1
    else num * factorial(num - 1)
}

function product_of_factorials(k: int): int
    requires k >= 0
    decreases k
{
    if k == 0 then 1
    else factorial(k) * product_of_factorials(k - 1)
}

method special_factorial(n: int) returns (result: int)
    ensures n <= 0 ==> result == 1
    ensures n > 0 ==> result == product_of_factorials(n)
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
            invariant result == product_of_factorials(i - 1)
        {
            result := result * factorial(i);
            i := i + 1;
        }
    }
}