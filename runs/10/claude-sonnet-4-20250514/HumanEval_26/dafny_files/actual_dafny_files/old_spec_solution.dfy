method remove_duplicates(numbers: seq<int>) returns (result: seq<int>)
    ensures forall x :: x in result ==> count_occurrences(numbers, x) == 1
    ensures forall x :: x in numbers && count_occurrences(numbers, x) == 1 ==> x in result
    ensures |result| <= |numbers|
{
    result := [];
    var i := 0;
    
    while i < |numbers|
        invariant 0 <= i <= |numbers|
        invariant forall x :: x in result ==> count_occurrences(numbers, x) == 1
        invariant forall j :: 0 <= j < i && count_occurrences(numbers, numbers[j]) == 1 ==> numbers[j] in result
        invariant forall x :: x in result ==> x in numbers[0..i]
    {
        if count_occurrences(numbers, numbers[i]) == 1 {
            result := result + [numbers[i]];
        }
        i := i + 1;
    }
}

function count_occurrences(s: seq<int>, target: int): int
    decreases s
{
    if |s| == 0 then 0
    else if s[0] == target then 1 + count_occurrences(s[1..], target)
    else count_occurrences(s[1..], target)
}