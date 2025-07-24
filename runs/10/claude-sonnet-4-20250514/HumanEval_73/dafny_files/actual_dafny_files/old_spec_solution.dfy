method smallest_change(arr: seq<int>) returns (changes: int)
    ensures changes >= 0
    ensures changes <= |arr| / 2
{
    var n := |arr|;
    changes := 0;
    
    var i := 0;
    while i < n / 2
        invariant 0 <= i <= n / 2
        invariant changes >= 0
        invariant changes <= i
        decreases n / 2 - i
    {
        if arr[i] != arr[n - 1 - i] {
            changes := changes + 1;
        }
        i := i + 1;
    }
}