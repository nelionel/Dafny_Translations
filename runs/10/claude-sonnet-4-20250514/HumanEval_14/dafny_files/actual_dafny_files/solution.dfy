method all_prefixes(s: string) returns (result: seq<string>)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < |result| ==> result[i] == s[0..i+1]
{
    result := [];
    var i := 1;
    while i <= |s|
        invariant 0 <= i <= |s| + 1
        invariant |result| == i - 1
        invariant forall j :: 0 <= j < |result| ==> result[j] == s[0..j+1]
        decreases |s| - i + 1
    {
        result := result + [s[0..i]];
        i := i + 1;
    }
}