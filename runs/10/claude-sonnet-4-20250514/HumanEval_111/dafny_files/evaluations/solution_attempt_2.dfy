method histogram(test: string) returns (result: seq<(string, int)>)
    ensures |result| >= 0
    // If input is empty or whitespace-only, result is empty
    ensures (forall i :: 0 <= i < |test| ==> test[i] == ' ') ==> |result| == 0
    // All returned pairs have the same count (the maximum count)
    ensures forall i, j :: 0 <= i < |result| && 0 <= j < |result| ==> result[i].1 == result[j].1
    // All counts in result are positive
    ensures forall i :: 0 <= i < |result| ==> result[i].1 > 0
    // All letters in result are distinct
    ensures forall i, j :: 0 <= i < |result| && 0 <= j < |result| && i != j ==> result[i].0 != result[j].0
    // All returned letters actually appear in the input with the claimed frequency
    ensures forall i :: 0 <= i < |result| ==> 
        var letter := result[i].0;
        var count := result[i].1;
        // The letter appears exactly 'count' times in the space-separated input
        CountLetterInSpaceSeparated(test, letter) == count
    // The returned count is the maximum possible count among all letters in input
    ensures forall i :: 0 <= i < |result| ==> 
        var maxCount := result[i].1;
        forall letter :: CountLetterInSpaceSeparated(test, letter) <= maxCount
    // All letters with maximum count are included in result
    ensures forall letter :: 
        CountLetterInSpaceSeparated(test, letter) > 0 && 
        (forall otherLetter :: CountLetterInSpaceSeparated(test, otherLetter) <= CountLetterInSpaceSeparated(test, letter))
        ==> 
        exists i :: 0 <= i < |result| && result[i].0 == letter
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

// Helper function to count occurrences of a letter in space-separated string
function CountLetterInSpaceSeparated(text: string, letter: string): int
{
    CountInSequence(ParseSpaceSeparated(text), letter)
}

// Helper function to parse space-separated string into sequence of letters
function ParseSpaceSeparated(text: string): seq<string>
{
    if |text| == 0 then []
    else ParseSpaceSeparatedHelper(text, 0, "")
}

function ParseSpaceSeparatedHelper(text: string, index: int, current: string): seq<string>
    requires 0 <= index <= |text|
    decreases |text| - index
{
    if index == |text| then
        if |current| > 0 then [current] else []
    else if text[index] == ' ' then
        if |current| > 0 then
            [current] + ParseSpaceSeparatedHelper(text, index + 1, "")
        else
            ParseSpaceSeparatedHelper(text, index + 1, "")
    else
        ParseSpaceSeparatedHelper(text, index + 1, current + [text[index]])
}

// Helper function to count occurrences in sequence
function CountInSequence(seq: seq<string>, item: string): int
{
    if |seq| == 0 then 0
    else (if seq[0] == item then 1 else 0) + CountInSequence(seq[1..], item)
}