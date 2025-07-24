method how_many_times(str: string, substring: string) returns (count: int)
    ensures count >= 0
{
    if |substring| == 0 {
        return 0;
    }
    
    count := 0;
    
    if |str| >= |substring| {
        var i := 0;
        while i <= |str| - |substring|
            invariant 0 <= i <= |str| - |substring| + 1
            invariant count >= 0
        {
            if str[i..i + |substring|] == substring {
                count := count + 1;
            }
            i := i + 1;
        }
    }
}