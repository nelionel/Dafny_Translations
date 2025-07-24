method reverse_delete(s: string, c: string) returns (result: string, is_palindrome: bool)
    ensures |result| <= |s|
    ensures is_palindrome <==> (result == reverse_string(result))
    ensures forall i :: 0 <= i < |result| ==> (result[i] in s && result[i] !in c)
    ensures forall i, j :: 0 <= i < j < |result| ==> 
        exists si, sj :: 0 <= si < sj < |s| && s[si] == result[i] && s[sj] == result[j]
    ensures forall i :: 0 <= i < |s| && s[i] !in c ==> s[i] in result
{
    // First, remove characters from s that are in c
    var filtered: string := "";
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant |filtered| <= i
        decreases |s| - i
    {
        var char_in_c := false;
        var j := 0;
        while j < |c|
            invariant 0 <= j <= |c|
            invariant char_in_c <==> (exists k :: 0 <= k < j && s[i] == c[k])
            decreases |c| - j
        {
            if s[i] == c[j] {
                char_in_c := true;
                break;
            }
            j := j + 1;
        }
        
        if !char_in_c {
            filtered := filtered + [s[i]];
        }
        i := i + 1;
    }
    
    // Check if filtered string is palindrome
    var palindrome := true;
    var left := 0;
    var right := |filtered| - 1;
    
    while left < right && palindrome
        invariant 0 <= left <= |filtered|
        invariant -1 <= right < |filtered|
        invariant left <= right ==> left + right == |filtered| - 1
        invariant palindrome ==> (forall k :: 0 <= k < left ==> filtered[k] == filtered[|filtered| - 1 - k])
        decreases right - left
    {
        if filtered[left] != filtered[right] {
            palindrome := false;
        } else {
            left := left + 1;
            right := right - 1;
        }
    }
    
    result := filtered;
    is_palindrome := palindrome;
}

function reverse_string(str: string): string
    decreases |str|
{
    if |str| == 0 then ""
    else reverse_string(str[1..]) + [str[0]]
}