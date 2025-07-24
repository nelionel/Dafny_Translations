method remove_duplicates(numbers: seq<int>) returns (result: seq<int>)
    ensures forall x :: x in result ==> count_occurrences(numbers, x) == 1
    ensures forall x :: x in numbers && count_occurrences(numbers, x) == 1 ==> x in result
    ensures |result| <= |numbers|
    ensures forall i, j :: 0 <= i < j < |result| ==> 
        exists pos_i, pos_j :: 0 <= pos_i < pos_j < |numbers| && 
        numbers[pos_i] == result[i] && numbers[pos_j] == result[j]
    ensures forall i, j :: 0 <= i < j < |result| ==> result[i] != result[j]
{
    result := [];
    var i := 0;
    
    while i < |numbers|
        invariant 0 <= i <= |numbers|
        invariant forall x :: x in result ==> count_occurrences(numbers, x) == 1
        invariant forall j :: 0 <= j < i && count_occurrences(numbers, numbers[j]) == 1 ==> numbers[j] in result
        invariant forall x :: x in result ==> x in numbers[0..i]
        invariant forall k, l :: 0 <= k < l < |result| ==> 
            exists pos_k, pos_l :: 0 <= pos_k < pos_l < i && 
            numbers[pos_k] == result[k] && numbers[pos_l] == result[l]
        invariant forall k, l :: 0 <= k < l < |result| ==> result[k] != result[l]
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