method make_a_pile(n: int) returns (pile: seq<int>)
    requires n > 0
    ensures |pile| == n
    ensures forall i :: 0 <= i < |pile| ==> pile[i] == n + 2 * i
{
    pile := [];
    var current_stones := n;
    var i := 0;
    
    while i < n
        invariant 0 <= i <= n
        invariant |pile| == i
        invariant current_stones == n + 2 * i
        invariant forall j :: 0 <= j < i ==> pile[j] == n + 2 * j
        decreases n - i
    {
        pile := pile + [current_stones];
        current_stones := current_stones + 2;
        i := i + 1;
    }
}