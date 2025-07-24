predicate StartsWith(s: string, prefix: string)
{
    |s| >= |prefix| && (|prefix| == 0 || s[0..|prefix|] == prefix)
}

method filter_by_prefix(strings: seq<string>, prefix: string) returns (result: seq<string>)
    ensures forall i :: 0 <= i < |result| ==> StartsWith(result[i], prefix)
    ensures forall s :: s in result ==> s in strings
    ensures forall s :: s in strings && StartsWith(s, prefix) ==> s in result
{
    result := [];
    for i := 0 to |strings|
        invariant 0 <= i <= |strings|
        invariant forall j :: 0 <= j < |result| ==> StartsWith(result[j], prefix)
        invariant forall s :: s in result ==> s in strings[0..i]
        invariant forall s :: s in strings[0..i] && StartsWith(s, prefix) ==> s in result
    {
        if StartsWith(strings[i], prefix) {
            result := result + [strings[i]];
        }
    }
}