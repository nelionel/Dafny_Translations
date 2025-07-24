method is_nested(s: string) returns (result: bool)
    requires forall i :: 0 <= i < |s| ==> s[i] == '[' || s[i] == ']'
    ensures result <==> (exists max_d, final_d :: max_d > 1 && max_d > final_d && ValidDepthAnalysis(s, max_d, final_d))
{
    var stack: seq<char> := [];
    var max_depth := 0;
    var current_depth := 0;
    var i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |stack| == current_depth
        invariant current_depth >= 0
        invariant max_depth >= current_depth
        invariant forall j :: 0 <= j < |stack| ==> stack[j] == '['
        decreases |s| - i
    {
        if s[i] == '[' {
            stack := stack + ['['];
            current_depth := current_depth + 1;
            if current_depth > max_depth {
                max_depth := current_depth;
            }
        } else { // s[i] == ']' by precondition
            if |stack| > 0 {
                stack := stack[..|stack|-1];
                current_depth := current_depth - 1;
            }
        }
        i := i + 1;
    }
    
    result := max_depth > 1 && max_depth > current_depth;
}

predicate ValidDepthAnalysis(s: string, max_d: int, final_d: int)
    requires forall i :: 0 <= i < |s| ==> s[i] == '[' || s[i] == ']'
{
    var depths := ComputeDepths(s);
    |depths| == |s| + 1 && 
    max_d == MaxInSeq(depths) &&
    final_d == depths[|depths|-1]
}

function ComputeDepths(s: string): seq<int>
    requires forall i :: 0 <= i < |s| ==> s[i] == '[' || s[i] == ']'
    decreases s
{
    if |s| == 0 then [0]
    else
        var prev_depths := ComputeDepths(s[..|s|-1]);
        var last_depth := prev_depths[|prev_depths|-1];
        if s[|s|-1] == '[' then
            prev_depths + [last_depth + 1]
        else // s[|s|-1] == ']'
            prev_depths + [if last_depth > 0 then last_depth - 1 else 0]
}

function MaxInSeq(depths: seq<int>): int
    requires |depths| > 0
    decreases depths
{
    if |depths| == 1 then depths[0]
    else
        var rest_max := MaxInSeq(depths[1..]);
        if depths[0] > rest_max then depths[0] else rest_max
}