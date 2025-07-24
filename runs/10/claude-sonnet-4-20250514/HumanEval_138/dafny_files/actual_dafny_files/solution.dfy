method is_equal_to_sum_even(n: int) returns (result: bool)
    ensures result == (n % 2 == 0 && n >= 8)
{
    result := n % 2 == 0 && n >= 8;
}