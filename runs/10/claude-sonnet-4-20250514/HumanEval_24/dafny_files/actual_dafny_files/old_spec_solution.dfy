method largest_divisor(n: int) returns (result: int)
    requires n > 1
    ensures result < n
    ensures n % result == 0
    ensures forall k :: result < k < n ==> n % k != 0
{
    var i := n / 2;
    while i > 0
        invariant 0 <= i <= n / 2
        invariant forall k :: i < k <= n / 2 ==> n % k != 0
        decreases i
    {
        if n % i == 0 {
            return i;
        }
        i := i - 1;
    }
    
    return 1;
}