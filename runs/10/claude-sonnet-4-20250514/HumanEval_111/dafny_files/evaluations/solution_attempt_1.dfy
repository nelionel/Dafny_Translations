method histogram(test: string) returns (result: seq<(string, int)>)
    requires forall i :: 0 <= i < |test| ==> test[i] == ' ' || ('a' <= test[i] <= 'z')
    ensures |result| >= 0
    ensures forall i, j :: 0 <= i < |result| && 0 <= j < |result| ==> result[i].1 == result[j].1
    ensures forall i :: 0 <= i < |result| ==> result[i].1 > 0
    ensures forall i, j :: 0 <= i < |result| && 0 <= j < |result| && i != j ==> result[i].0 != result[j].0
    ensures (|test| == 0 || (forall i :: 0 <= i < |test| ==> test[i] == ' ')) ==> |result| == 0
    ensures |result| > 0 ==> exists letters: seq<string> :: 
        (forall letter :: letter in letters <==> exists i, j :: 0 <= i < j <= |test| && 
         (forall k :: i <= k < j ==> test[k] != ' ') && i > 0 ==> test[i-1] == ' ' && 
         j < |test| ==> test[j] == ' ' && letter == test[i..j]) &&
        (forall i :: 0 <= i < |result| ==> result[i].0 in letters) &&
        (forall letter :: letter in letters ==> 
         exists count :: count > 0 && 
         (count == |seq(i | 0 <= i < |letters| && letters[i] == letter)| &&
          (exists j :: 0 <= j < |result| && result[j] == (letter, count)) ||
           (forall j :: 0 <= j < |result| ==> result[j].1 >= count)))
{
    if |test| == 0 {
        return [];
    }
    
    // Parse letters from space-separated string
    var letters: seq<string> := [];
    var i := 0;
    var currentLetter := "";
    
    while i < |test|
        invariant 0 <= i <= |test|
        invariant |currentLetter| >= 0
        decreases |test| - i
    {
        if test[i] == ' ' {
            if |currentLetter| > 0 {
                letters := letters + [currentLetter];
                currentLetter := "";
            }
        } else {
            currentLetter := currentLetter + [test[i]];
        }
        i := i + 1;
    }
    
    // Add the last letter if any
    if |currentLetter| > 0 {
        letters := letters + [currentLetter];
    }
    
    if |letters| == 0 {
        return [];
    }
    
    // Count frequencies using parallel sequences
    var uniqueLetters: seq<string> := [];
    var counts: seq<int> := [];
    
    i := 0;
    while i < |letters|
        invariant 0 <= i <= |letters|
        invariant |uniqueLetters| == |counts|
        invariant forall k :: 0 <= k < |counts| ==> counts[k] > 0
        decreases |letters| - i
    {
        var letter := letters[i];
        var found := false;
        var j := 0;
        
        while j < |uniqueLetters|
            invariant 0 <= j <= |uniqueLetters|
            invariant |uniqueLetters| == |counts|
            decreases |uniqueLetters| - j
        {
            if uniqueLetters[j] == letter {
                counts := counts[j := counts[j] + 1];
                found := true;
                break;
            }
            j := j + 1;
        }
        
        if !found {
            uniqueLetters := uniqueLetters + [letter];
            counts := counts + [1];
        }
        i := i + 1;
    }
    
    // Find maximum count
    if |counts| == 0 {
        return [];
    }
    
    var maxCount := counts[0];
    i := 1;
    while i < |counts|
        invariant 1 <= i <= |counts|
        invariant maxCount > 0
        invariant exists k :: 0 <= k < |counts| && counts[k] == maxCount
        decreases |counts| - i
    {
        if counts[i] > maxCount {
            maxCount := counts[i];
        }
        i := i + 1;
    }
    
    // Collect all letters with maximum count
    result := [];
    i := 0;
    while i < |uniqueLetters|
        invariant 0 <= i <= |uniqueLetters|
        invariant |uniqueLetters| == |counts|
        invariant forall k :: 0 <= k < |result| ==> result[k].1 == maxCount
        decreases |uniqueLetters| - i
    {
        if counts[i] == maxCount {
            result := result + [(uniqueLetters[i], counts[i])];
        }
        i := i + 1;
    }
}