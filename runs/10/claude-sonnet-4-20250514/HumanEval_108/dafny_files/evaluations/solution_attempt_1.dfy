function SumOfDigits(n: int): int
    requires n >= 0
    decreases n
{
    if n == 0 then 0
    else (n % 10) + SumOfDigits(n / 10)
}

function FirstDigit(n: int): int
    requires n > 0
    decreases n
{
    if n < 10 then n
    else FirstDigit(n / 10)
}

function DigitSum(n: int): int
{
    if n == 0 then 
        0
    else if n > 0 then 
        SumOfDigits(n)
    else 
        var absN := -n;
        var total := SumOfDigits(absN);
        var firstDigit := FirstDigit(absN);
        total - 2 * firstDigit
}

method count_nums(arr: seq<int>) returns (count: int)
    ensures count >= 0
    ensures count <= |arr|
    ensures count == |set i | 0 <= i < |arr| && DigitSum(arr[i]) > 0|
{
    count := 0;
    var i := 0;
    while i < |arr|
        invariant 0 <= i <= |arr|
        invariant 0 <= count <= i
        invariant count == |set j | 0 <= j < i && DigitSum(arr[j]) > 0|
    {
        if DigitSum(arr[i]) > 0 {
            count := count + 1;
        }
        i := i + 1;
    }
}