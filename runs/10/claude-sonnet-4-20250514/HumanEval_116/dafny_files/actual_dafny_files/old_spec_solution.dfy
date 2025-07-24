method sort_array(arr: seq<int>) returns (result: seq<int>)
    ensures |result| == |arr|
    ensures multiset(result) == multiset(arr)
    ensures forall i, j :: 0 <= i < j < |result| ==> 
        less_or_equal_by_criteria(result[i], result[j])
{
    result := arr;
    
    // Bubble sort implementation
    var n := |result|;
    var i := 0;
    while i < n
        invariant 0 <= i <= n
        invariant |result| == n == |arr|
        invariant multiset(result) == multiset(arr)
        decreases n - i
    {
        var j := 0;
        while j < n - 1 - i
            invariant 0 <= j <= n - 1 - i
            invariant |result| == n == |arr|
            invariant multiset(result) == multiset(arr)
            decreases n - 1 - i - j
        {
            if should_swap(result[j], result[j+1]) {
                result := result[j := result[j+1]][j+1 := result[j]];
            }
            j := j + 1;
        }
        i := i + 1;
    }
}

function abs(n: int): int
{
    if n >= 0 then n else -n
}

function count_ones(n: int): int
    requires n >= 0
    decreases n
{
    if n == 0 then 0
    else (n % 2) + count_ones(n / 2)
}

predicate should_swap(a: int, b: int)
{
    var ones_a := count_ones(abs(a));
    var ones_b := count_ones(abs(b));
    ones_a > ones_b || (ones_a == ones_b && a > b)
}

predicate less_or_equal_by_criteria(a: int, b: int)
{
    var ones_a := count_ones(abs(a));
    var ones_b := count_ones(abs(b));
    ones_a < ones_b || (ones_a == ones_b && a <= b)
}