method encrypt(s: string) returns (result: string)
    ensures |result| == |s|
    ensures forall i :: 0 <= i < |s| ==> 
        (('a' <= s[i] && s[i] <= 'z') ==> result[i] == (((s[i] as int - 'a' as int + 4) % 26) + 'a' as int) as char) &&
        (('A' <= s[i] && s[i] <= 'Z') ==> result[i] == (((s[i] as int - 'A' as int + 4) % 26) + 'A' as int) as char) &&
        (!(('a' <= s[i] && s[i] <= 'z') || ('A' <= s[i] && s[i] <= 'Z')) ==> result[i] == s[i])
{
    result := "";
    var i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> 
            (('a' <= s[j] && s[j] <= 'z') ==> result[j] == (((s[j] as int - 'a' as int + 4) % 26) + 'a' as int) as char) &&
            (('A' <= s[j] && s[j] <= 'Z') ==> result[j] == (((s[j] as int - 'A' as int + 4) % 26) + 'A' as int) as char) &&
            (!(('a' <= s[j] && s[j] <= 'z') || ('A' <= s[j] && s[j] <= 'Z')) ==> result[j] == s[j])
        decreases |s| - i
    {
        var c := s[i];
        var shifted: char;
        
        if 'a' <= c && c <= 'z' {
            // Shift lowercase letters
            shifted := (((c as int - 'a' as int + 4) % 26) + 'a' as int) as char;
        } else if 'A' <= c && c <= 'Z' {
            // Shift uppercase letters  
            shifted := (((c as int - 'A' as int + 4) % 26) + 'A' as int) as char;
        } else {
            // Non-alphabetic characters remain unchanged
            shifted := c;
        }
        
        result := result + [shifted];
        i := i + 1;
    }
}