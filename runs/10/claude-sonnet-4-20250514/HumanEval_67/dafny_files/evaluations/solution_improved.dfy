method fruit_distribution(s: string, n: int) returns (mangoes: int)
    requires n >= 0
    requires n >= SumOfNumbersInString(s)
    ensures mangoes >= 0
    ensures mangoes == n - SumOfNumbersInString(s)
{
    var numbers := ExtractNumbers(s);
    var total_apples_oranges := SumSequence(numbers);
    mangoes := n - total_apples_oranges;
}

function IsDigit(c: char): bool
{
    '0' <= c <= '9'
}

function CharToInt(c: char): int
    requires IsDigit(c)
{
    (c as int) - ('0' as int)
}

function ExtractNumbers(s: string): seq<int>
    decreases |s|
{
    if |s| == 0 then []
    else ExtractNumbersHelper(s, 0, 0, [])
}

function ExtractNumbersHelper(s: string, pos: int, current_num: int, acc: seq<int>): seq<int>
    requires 0 <= pos <= |s|
    decreases |s| - pos
{
    if pos == |s| then
        if current_num > 0 then acc + [current_num] else acc
    else if IsDigit(s[pos]) then
        ExtractNumbersHelper(s, pos + 1, current_num * 10 + CharToInt(s[pos]), acc)
    else
        var new_acc := if current_num > 0 then acc + [current_num] else acc;
        ExtractNumbersHelper(s, pos + 1, 0, new_acc)
}

function SumSequence(numbers: seq<int>): int
    decreases numbers
{
    if |numbers| == 0 then 0
    else numbers[0] + SumSequence(numbers[1..])
}

function SumOfNumbersInString(s: string): int
{
    SumSequence(ExtractNumbers(s))
}