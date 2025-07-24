function reverse(s: string): string
    decreases |s|
{
    if |s| == 0 then ""
    else reverse(s[1..]) + [s[0]]
}

function is_palindrome(s: string): bool
{
    s == reverse(s)
}

method make_palindrome(s: string) returns (result: string)
    ensures |result| >= |s|
    ensures s == "" ==> result == ""
    ensures s != "" ==> result[..|s|] == s
    ensures is_palindrome(result)
    ensures forall p :: (|p| >= |s| && (s == "" || p[..|s|] == s) && is_palindrome(p)) ==> |result| <= |p|
{
    if |s| == 0 {
        return "";
    }
    
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        decreases |s| - i
    {
        var suffix := s[i..];
        if is_palindrome(suffix) {
            var prefix := s[..i];
            result := s + reverse(prefix);
            return;
        }
        i := i + 1;
    }
    
    // This should never be reached since a single character is always a palindrome
    result := s;
}