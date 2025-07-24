function UniqueCharCount(s: string): int
{
    |set c | 0 <= c < |s| :: s[c]|
}

method find_max(words: seq<string>) returns (result: string)
    ensures |words| == 0 ==> result == ""
    ensures |words| > 0 ==> result in words
    ensures |words| > 0 ==> forall w :: w in words ==> UniqueCharCount(w) <= UniqueCharCount(result)
    ensures |words| > 0 ==> forall w :: w in words && UniqueCharCount(w) == UniqueCharCount(result) ==> result <= w
{
    if |words| == 0 {
        return "";
    }
    
    var maxUniqueCount := UniqueCharCount(words[0]);
    result := words[0];
    
    var i := 1;
    while i < |words|
        invariant 1 <= i <= |words|
        invariant result in words[..i]
        invariant maxUniqueCount == UniqueCharCount(result)
        invariant forall j :: 0 <= j < i ==> UniqueCharCount(words[j]) <= maxUniqueCount
        invariant forall j :: 0 <= j < i && UniqueCharCount(words[j]) == maxUniqueCount ==> result <= words[j]
        decreases |words| - i
    {
        var currentUniqueCount := UniqueCharCount(words[i]);
        
        if currentUniqueCount > maxUniqueCount {
            maxUniqueCount := currentUniqueCount;
            result := words[i];
        } else if currentUniqueCount == maxUniqueCount && words[i] < result {
            result := words[i];
        }
        
        i := i + 1;
    }
}