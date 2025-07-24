function count_mismatches(arr: seq<int>, i: int): int
    requires 0 <= i <= |arr| / 2
{
    if i == |arr| / 2 then 0
    else if arr[i] != arr[|arr| - 1 - i] then 1 + count_mismatches(arr, i + 1)
    else count_mismatches(arr, i + 1)
}

method smallest_change(arr: seq<int>) returns (changes: int)
    ensures changes >= 0
    ensures changes <= |arr| / 2
    ensures changes == count_mismatches(arr, 0)
{
    var n := |arr|;
    changes := 0;
    
    var i := 0;
    while i < n / 2
        invariant 0 <= i <= n / 2
        invariant changes >= 0
        invariant changes <= i
        invariant changes == count_mismatches(arr, 0) - count_mismatches(arr, i)
        decreases n / 2 - i
    {
        if arr[i] != arr[n - 1 - i] {
            changes := changes + 1;
        }
        i := i + 1;
    }
}