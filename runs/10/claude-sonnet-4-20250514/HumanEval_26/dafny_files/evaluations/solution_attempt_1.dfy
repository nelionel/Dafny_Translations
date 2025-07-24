method remove_duplicates(numbers: seq<int>) returns (result: seq<int>)
    ensures forall x :: x in result ==> count_occurrences(numbers, x) == 1
    ensures forall x :: x in numbers && count_occurrences(numbers, x) == 1 ==> x in result
    ensures |result| <= |numbers|
    ensures preserves_order(numbers, result)
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

predicate preserves_order(original: seq<int>, filtered: seq<int>)
{
    exists indices: seq<int> ::
        |indices| == |filtered| &&
        (forall i :: 0 <= i < |indices| ==> 0 <= indices[i] < |original|) &&
        (forall i :: 0 <= i < |indices| ==> original[indices[i]] == filtered[i]) &&
        (forall i, j :: 0 <= i < j < |indices| ==> indices[i] < indices[j])
}