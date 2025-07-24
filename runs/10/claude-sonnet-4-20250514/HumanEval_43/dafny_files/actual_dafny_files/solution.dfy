predicate Contains(s: seq<int>, x: int)
{
    exists i :: 0 <= i < |s| && s[i] == x
}

method pairs_sum_to_zero(l: seq<int>) returns (result: bool)
    ensures result <==> (exists i, j :: 0 <= i < |l| && 0 <= j < |l| && i != j && l[i] + l[j] == 0)
{
    var seen: seq<int> := [];
    var index := 0;
    
    while index < |l|
        invariant 0 <= index <= |l|
        invariant |seen| == index
        invariant forall k :: 0 <= k < index ==> seen[k] == l[k]
        invariant forall i, j :: 0 <= i < index && 0 <= j < index && i != j ==> l[i] + l[j] != 0
        decreases |l| - index
    {
        var num := l[index];
        
        if Contains(seen, -num) {
            return true;
        }
        
        seen := seen + [num];
        index := index + 1;
    }
    
    return false;
}