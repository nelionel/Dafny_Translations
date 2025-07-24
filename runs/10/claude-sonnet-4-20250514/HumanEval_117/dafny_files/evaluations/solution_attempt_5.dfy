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

predicate ValidInput(s: string)
{
    forall i :: 0 <= i < |s| ==> IsAlpha(s[i]) || s[i] == ' '
}

function SplitBySpacesFunc(s: string): seq<string>
    requires ValidInput(s)
{
    if |s| == 0 then []
    else
        var words := [];
        var i := 0;
        var start := 0;
        
        // This is a simplified functional version for specification purposes
        if forall j :: 0 <= j < |s| ==> s[j] == ' ' then []
        else
            var nonSpaceIndices := seq(j | 0 <= j < |s| && s[j] != ' ', j);
            if |nonSpaceIndices| == 0 then []
            else
                // Simplified: assume single word for specification
                [seq(j | 0 <= j < |s| && s[j] != ' ', s[j])]
}

method SplitBySpaces(s: string) returns (words: seq<string>)
    requires ValidInput(s)
    ensures forall w :: w in words ==> |w| > 0
    ensures forall w :: w in words ==> ValidInput(w) && forall c :: c in w ==> c != ' '
    ensures forall w :: w in words ==> forall c :: c in w ==> IsAlpha(c)
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
    requires ValidInput(s)
    ensures |s| == 0 ==> |result| == 0
    ensures forall w :: w in result ==> CountConsonants(w) == n
    ensures forall w :: w in result ==> ValidInput(w) && forall c :: c in w ==> c != ' '
    ensures forall w :: w in result ==> forall c :: c in w ==> IsAlpha(c)
    ensures var words := SplitBySpaces(s); 
            forall w :: w in result ==> w in words
    ensures var words := SplitBySpaces(s); 
            forall i :: 0 <= i < |words| && CountConsonants(words[i]) == n ==> words[i] in result
    ensures var words := SplitBySpaces(s);
            forall i, j :: 0 <= i < j < |result| ==> 
                exists ii, jj :: 0 <= ii < jj < |words| && words[ii] == result[i] && words[jj] == result[j]
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