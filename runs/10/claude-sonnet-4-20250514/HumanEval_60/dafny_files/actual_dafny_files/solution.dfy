method sum_to_n(n: int) returns (result: int)
    requires n >= 0
    ensures result == n * (n + 1) / 2
{
    result := n * (n + 1) / 2;
}