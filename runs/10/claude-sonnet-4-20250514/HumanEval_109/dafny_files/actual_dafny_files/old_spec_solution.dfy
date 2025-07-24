method move_one_ball(arr: seq<int>) returns (result: bool)
    ensures result == (|arr| == 0 || exists k :: 0 <= k < |arr| && rotate_right(arr, k) == sort_sequence(arr))
{
    if |arr| == 0 {
        return true;
    }
    
    var sorted_arr := sort_sequence(arr);
    var doubled_arr := arr + arr;
    
    // Check if sorted_arr appears as a contiguous subsequence in doubled_arr
    var i := 0;
    while i <= |doubled_arr| - |arr|
        invariant 0 <= i <= |doubled_arr| - |arr| + 1
        invariant forall j :: 0 <= j < i ==> doubled_arr[j..j+|arr|] != sorted_arr
        decreases |doubled_arr| - |arr| - i
    {
        if i + |arr| <= |doubled_arr| && doubled_arr[i..i+|arr|] == sorted_arr {
            return true;
        }
        i := i + 1;
    }
    
    return false;
}

function rotate_right(arr: seq<int>, k: int): seq<int>
    requires 0 <= k
    ensures |rotate_right(arr, k)| == |arr|
{
    if |arr| == 0 then 
        arr
    else 
        var effective_k := k % |arr|;
        arr[|arr| - effective_k..] + arr[..|arr| - effective_k]
}

function sort_sequence(arr: seq<int>): seq<int>
    ensures |sort_sequence(arr)| == |arr|
    ensures forall i, j :: 0 <= i < j < |sort_sequence(arr)| ==> sort_sequence(arr)[i] <= sort_sequence(arr)[j]
    ensures multiset(sort_sequence(arr)) == multiset(arr)
    decreases |arr|
{
    if |arr| <= 1 then 
        arr
    else
        var pivot := arr[0];
        var rest := arr[1..];
        var smaller := filter_leq(rest, pivot);
        var larger := filter_gt(rest, pivot);
        sort_sequence(smaller) + [pivot] + sort_sequence(larger)
}

function filter_leq(arr: seq<int>, pivot: int): seq<int>
    ensures |filter_leq(arr, pivot)| <= |arr|
    ensures forall x :: x in filter_leq(arr, pivot) ==> x <= pivot && x in arr
    ensures forall x :: x in arr && x <= pivot ==> x in filter_leq(arr, pivot)
    decreases |arr|
{
    if |arr| == 0 then 
        []
    else if arr[0] <= pivot then 
        [arr[0]] + filter_leq(arr[1..], pivot)
    else 
        filter_leq(arr[1..], pivot)
}

function filter_gt(arr: seq<int>, pivot: int): seq<int>
    ensures |filter_gt(arr, pivot)| <= |arr|
    ensures forall x :: x in filter_gt(arr, pivot) ==> x > pivot && x in arr
    ensures forall x :: x in arr && x > pivot ==> x in filter_gt(arr, pivot)
    decreases |arr|
{
    if |arr| == 0 then 
        []
    else if arr[0] > pivot then 
        [arr[0]] + filter_gt(arr[1..], pivot)
    else 
        filter_gt(arr[1..], pivot)
}