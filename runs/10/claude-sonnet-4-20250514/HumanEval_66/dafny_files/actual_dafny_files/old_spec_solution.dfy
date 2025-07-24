method digitSum(s: string) returns (result: int)
    ensures result >= 0
{
    var total := 0;
    var i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant total >= 0
        decreases |s| - i
    {
        if 'A' <= s[i] <= 'Z' {
            total := total + (s[i] as int);
        }
        i := i + 1;
    }
    
    result := total;
}