method count_upper(s: string) returns (count: int)
    ensures count >= 0
    ensures count <= (|s| + 1) / 2  // at most the number of even indices
    ensures count == |set i | 0 <= i < |s| && i % 2 == 0 && is_uppercase_vowel(s[i])|
{
    count := 0;
    var i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant i % 2 == 0  // i is always even
        invariant count >= 0
        invariant count <= i / 2  // count doesn't exceed number of even indices processed so far
        invariant count == |set j | 0 <= j < i && j % 2 == 0 && is_uppercase_vowel(s[j])|
        decreases |s| - i
    {
        if is_uppercase_vowel(s[i]) {
            count := count + 1;
        }
        i := i + 2;
    }
}

predicate is_uppercase_vowel(c: char)
{
    c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U'
}