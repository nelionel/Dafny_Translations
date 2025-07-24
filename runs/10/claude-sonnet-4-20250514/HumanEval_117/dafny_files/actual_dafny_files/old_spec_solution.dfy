function IsVowel(c: char): bool
{
    c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' ||
    c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U'
}

function IsAlpha(c: char): bool
{
    ('a' <= c <= 'z') || ('A' <= c <= 'Z')
}

function CountConsonants(word: string): nat
{
    if |word| == 0 then 0
    else 
        var count := if IsAlpha(word[0]) && !IsVowel(word[0]) then 1 else 0;
        count + CountConsonants(word[1..])
}

method SplitBySpaces(s: string) returns (words: seq<string>)
{
    words := [];
    if |s| == 0 {
        return;
    }
    
    var i := 0;
    var start := 0;
    
    // Skip leading spaces
    while i < |s| && s[i] == ' '
        invariant 0 <= i <= |s|
        decreases |s| - i
    {
        i := i + 1;
    }
    
    start := i;
    
    while i <= |s|
        invariant 0 <= start <= i <= |s|
        invariant forall w :: w in words ==> |w| > 0
        decreases |s| - i + 1
    {
        if i == |s| || s[i] == ' ' {
            if start < i {
                var word := s[start..i];
                words := words + [word];
            }
            
            // Skip spaces
            while i < |s| && s[i] == ' '
                invariant i <= |s|
                decreases |s| - i
            {
                i := i + 1;
            }
            start := i;
        } else {
            i := i + 1;
        }
    }
}

method select_words(s: string, n: nat) returns (result: seq<string>)
    ensures |result| >= 0
{
    if |s| == 0 {
        result := [];
        return;
    }
    
    var words := SplitBySpaces(s);
    result := [];
    
    var i := 0;
    while i < |words|
        invariant 0 <= i <= |words|
        invariant |result| >= 0
        decreases |words| - i
    {
        var consonantCount := CountConsonants(words[i]);
        if consonantCount == n {
            result := result + [words[i]];
        }
        i := i + 1;
    }
}