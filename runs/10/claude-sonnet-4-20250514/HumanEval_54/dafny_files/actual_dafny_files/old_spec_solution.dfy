method same_chars(s0: string, s1: string) returns (result: bool)
    ensures result <==> (set c | c in s0) == (set c | c in s1)
{
    var set0 := set c | c in s0;
    var set1 := set c | c in s1;
    result := set0 == set1;
}