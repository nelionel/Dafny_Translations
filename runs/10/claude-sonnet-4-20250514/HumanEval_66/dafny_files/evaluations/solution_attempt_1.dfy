function sumUpperCaseASCII(s: string): int
{
    if |s| == 0 then 0
    else (if 'A' <= s[0] <= 'Z' then s[0] as int else 0) + sumUpperCaseASCII(s[1..])
}

method digitSum(s: string) returns (result: int)
    ensures result == sumUpperCaseASCII(s)
    ensures result >= 0
{
    var total := 0;
    var i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant total >= 0
        invariant total == sumUpperCaseASCII(s[..i])
        decreases |s| - i
    {
        if 'A' <= s[i] <= 'Z' {
            total := total + (s[i] as int);
        }
        i := i + 1;
    }
    
    result := total;
}