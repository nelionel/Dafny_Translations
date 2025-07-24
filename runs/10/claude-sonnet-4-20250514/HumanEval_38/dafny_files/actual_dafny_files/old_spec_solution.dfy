method decode_cyclic(s: string) returns (result: string)
    ensures |result| == |s|
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