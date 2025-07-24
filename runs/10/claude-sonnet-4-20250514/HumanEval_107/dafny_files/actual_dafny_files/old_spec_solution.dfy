method even_odd_palindrome(n: int) returns (result: seq<int>)
    requires n >= 1
    ensures |result| == 2
    ensures result[0] >= 0 && result[1] >= 0
{
    var even_count := 0;
    var odd_count := 0;
    var i := 1;
    
    while i <= n
        invariant 1 <= i <= n + 1
        invariant even_count >= 0 && odd_count >= 0
        invariant even_count + odd_count <= i - 1
    {
        if is_palindrome(i) {
            if i % 2 == 0 {
                even_count := even_count + 1;
            } else {
                odd_count := odd_count + 1;
            }
        }
        i := i + 1;
    }
    
    result := [even_count, odd_count];
}

function is_palindrome(num: int): bool
    requires num >= 0
{
    num == reverse_digits(num)
}

function reverse_digits(num: int): int
    requires num >= 0
    decreases num
{
    if num < 10 then
        num
    else
        (num % 10) * power_of_ten(count_digits(num) - 1) + reverse_digits(num / 10)
}

function count_digits(num: int): int
    requires num >= 0
    decreases num
{
    if num < 10 then
        1
    else
        1 + count_digits(num / 10)
}

function power_of_ten(exp: int): int
    requires exp >= 0
    decreases exp
{
    if exp == 0 then
        1
    else
        10 * power_of_ten(exp - 1)
}