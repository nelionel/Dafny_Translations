function IsSubstring(needle: string, haystack: string): bool
{
    if |needle| == 0 then true
    else if |needle| > |haystack| then false
    else exists i :: 0 <= i <= |haystack| - |needle| && haystack[i..i+|needle|] == needle
}

method cycpattern_check(a: string, b: string) returns (result: bool)
    ensures result <==> (|b| == 0 || exists i :: 0 <= i < |b| && IsSubstring(b[i..] + b[..i], a))
{
    if |b| == 0 {
        return true;
    }
    
    if |b| > |a| {
        return false;
    }
    
    var i := 0;
    while i < |b|
        invariant 0 <= i <= |b|
        invariant forall j :: 0 <= j < i ==> !IsSubstring(b[j..] + b[..j], a)
        decreases |b| - i
    {
        var rotation := b[i..] + b[..i];
        if IsSubstring(rotation, a) {
            return true;
        }
        i := i + 1;
    }
    
    return false;
}