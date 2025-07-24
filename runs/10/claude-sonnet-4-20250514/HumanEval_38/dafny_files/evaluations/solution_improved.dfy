method decode_cyclic(s: string) returns (result: string)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < (|s| + 2) / 3 ==>
        var group_start := 3 * i;
        var group_end := if group_start + 3 <= |s| then group_start + 3 else |s|;
        var group_len := group_end - group_start;
        group_len > 0 ==> (
            if group_len == 3 then
                // For groups of length 3, last char moves to front (reverse cycle)
                result[group_start..group_end] == [s[group_end-1]] + s[group_start..group_end-1]
            else
                // For groups with fewer than 3 chars, they remain unchanged
                result[group_start..group_end] == s[group_start..group_end]
        )
{
    var chars := s;
    var decoded: seq<char> := [];
    var i := 0;
    
    while i < |chars|
        invariant 0 <= i <= |chars|
        invariant |decoded| == i
        decreases |chars| - i
    {
        var group_end := if i + 3 <= |chars| then i + 3 else |chars|;
        var group := chars[i..group_end];
        
        var processed_group: seq<char>;
        if |group| == 3 {
            // Reverse cycle: move last character to front
            processed_group := [group[2]] + group[0..2];
        } else {
            // Keep group unchanged if it has fewer than 3 characters
            processed_group := group;
        }
        
        decoded := decoded + processed_group;
        i := i + 3;
    }
    
    result := decoded;
}