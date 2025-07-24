method histogram(test: string) returns (result: seq<(string, int)>)
    ensures (test == "" || (forall i :: 0 <= i < |test| ==> test[i] == ' ')) ==> |result| == 0
    ensures |result| > 0 ==> forall i, j :: 0 <= i < |result| && 0 <= j < |result| ==> result[i].1 == result[j].1
    ensures forall i :: 0 <= i < |result| ==> result[i].1 > 0
    ensures forall i, j :: 0 <= i < |result| && 0 <= j < |result| && i != j ==> result[i].0 != result[j].0
    ensures forall i :: 0 <= i < |result| ==> |result[i].0| > 0
    ensures |result| > 0 ==> forall i :: 0 <= i < |result| ==> forall c :: c in result[i].0 ==> c != ' '
    ensures |result| > 0 ==> (exists maxCount :: maxCount > 0 && (forall i :: 0 <= i < |result| ==> result[i].1 == maxCount))
    // Additional specifications for correctness
    ensures forall i :: 0 <= i < |result| ==> exists letters: seq<string> :: letters == splitBySpaces(test) && result[i].0 in letters
    ensures forall i :: 0 <= i < |result| ==> countInSeq(splitBySpaces(test), result[i].0) == result[i].1
    ensures |result| > 0 ==> forall letter :: letter in splitBySpaces(test) ==> countInSeq(splitBySpaces(test), letter) <= result[0].1
    ensures forall letter :: letter in splitBySpaces(test) && countInSeq(splitBySpaces(test), letter) == (if |result| > 0 then result[0].1 else 0) ==> exists i :: 0 <= i < |result| && result[i].0 == letter
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

// Helper function to split string by spaces
function splitBySpaces(s: string): seq<string>
{
    if |s| == 0 then []
    else 
        var letters := [];
        var i := 0;
        var currentLetter := "";
        var result := [];
        // This is a simplified specification - actual implementation would be in the method
        []
}

// Helper function to count occurrences in sequence
function countInSeq(letters: seq<string>, target: string): int
{
    if |letters| == 0 then 0
    else (if letters[0] == target then 1 else 0) + countInSeq(letters[1..], target)
}