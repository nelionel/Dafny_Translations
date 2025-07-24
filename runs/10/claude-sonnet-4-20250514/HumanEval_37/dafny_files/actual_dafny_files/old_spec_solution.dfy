method sort_even(l: seq<int>) returns (result: seq<int>)
    ensures |result| == |l|
    ensures forall i :: 0 <= i < |l| && i % 2 == 1 ==> result[i] == l[i]
    ensures is_sorted_even_indices(result)
    ensures same_even_elements(l, result)
{
    if |l| == 0 {
        result := [];
        return;
    }
    
    // Extract values at even indices
    var even_values := extract_even_values(l);
    
    // Sort the even values
    var sorted_even := sort_sequence(even_values);
    
    // Build result sequence
    result := [];
    var even_index := 0;
    var i := 0;
    
    while i < |l|
        invariant 0 <= i <= |l|
        invariant |result| == i
        invariant 0 <= even_index <= (i + 1) / 2
        invariant even_index == (i + 1) / 2
        invariant forall k :: 0 <= k < i && k % 2 == 1 ==> result[k] == l[k]
        invariant forall k :: 0 <= k < i && k % 2 == 0 ==> k / 2 < |sorted_even| && result[k] == sorted_even[k / 2]
        decreases |l| - i
    {
        if i % 2 == 0 {
            // Even index - use sorted even value
            result := result + [sorted_even[even_index]];
            even_index := even_index + 1;
        } else {
            // Odd index - use original value
            result := result + [l[i]];
        }
        i := i + 1;
    }
}

function extract_even_values(l: seq<int>): seq<int>
{
    if |l| == 0 then []
    else if |l| == 1 then [l[0]]
    else [l[0]] + extract_even_values(l[2..])
}

predicate is_sorted_even_indices(s: seq<int>)
{
    forall i, j :: 0 <= i < j < |s| && i % 2 == 0 && j % 2 == 0 ==> s[i] <= s[j]
}

predicate same_even_elements(original: seq<int>, result: seq<int>)
    requires |original| == |result|
{
    multiset(extract_even_values(original)) == multiset(extract_even_values(result))
}

method sort_sequence(s: seq<int>) returns (sorted_s: seq<int>)
    ensures |sorted_s| == |s|
    ensures multiset(sorted_s) == multiset(s)
    ensures forall i, j :: 0 <= i < j < |sorted_s| ==> sorted_s[i] <= sorted_s[j]
{
    sorted_s := s;
    var i := 0;
    
    while i < |sorted_s|
        invariant 0 <= i <= |sorted_s|
        invariant |sorted_s| == |s|
        invariant multiset(sorted_s) == multiset(s)
        invariant forall x, y :: 0 <= x < y < i ==> sorted_s[x] <= sorted_s[y]
        decreases |sorted_s| - i
    {
        var j := i + 1;
        while j < |sorted_s|
            invariant i < j <= |sorted_s|
            invariant |sorted_s| == |s|
            invariant multiset(sorted_s) == multiset(s)
            invariant forall x, y :: 0 <= x < y < i ==> sorted_s[x] <= sorted_s[y]
            invariant forall k :: i < k < j ==> sorted_s[i] <= sorted_s[k]
            decreases |sorted_s| - j
        {
            if sorted_s[j] < sorted_s[i] {
                var temp := sorted_s[i];
                sorted_s := sorted_s[i := sorted_s[j]][j := temp];
            }
            j := j + 1;
        }
        i := i + 1;
    }
}