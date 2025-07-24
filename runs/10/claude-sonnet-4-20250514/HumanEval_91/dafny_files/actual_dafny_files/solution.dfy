method is_bored(S: string) returns (count: int)
    ensures count >= 0
    ensures count == CountSentencesStartingWithI(S)
{
    count := 0;
    var currentSentence := "";
    var i := 0;
    
    while i <= |S|
        invariant 0 <= i <= |S| + 1
        invariant count >= 0
        decreases |S| + 1 - i
    {
        if i == |S| || isDelimiter(S[i]) {
            // Process current sentence
            var trimmed := trim(currentSentence);
            if |trimmed| > 0 {
                var words := splitBySpaces(trimmed);
                if |words| > 0 && words[0] == "I" {
                    count := count + 1;
                }
            }
            currentSentence := "";
        } else {
            currentSentence := currentSentence + [S[i]];
        }
        i := i + 1;
    }
}

function CountSentencesStartingWithI(S: string): int
    ensures CountSentencesStartingWithI(S) >= 0
{
    var sentences := SplitBySentenceDelimiters(S);
    CountIStartingSentences(sentences)
}

function SplitBySentenceDelimiters(s: string): seq<string>
{
    if |s| == 0 then [""]
    else SplitBySentenceDelimitersHelper(s, 0, "")
}

function SplitBySentenceDelimitersHelper(s: string, i: int, current: string): seq<string>
    requires 0 <= i <= |s|
    decreases |s| - i
{
    if i == |s| then [current]
    else if isDelimiter(s[i]) then
        [current] + SplitBySentenceDelimitersHelper(s, i + 1, "")
    else
        SplitBySentenceDelimitersHelper(s, i + 1, current + [s[i]])
}

function CountIStartingSentences(sentences: seq<string>): int
    ensures CountIStartingSentences(sentences) >= 0
{
    if |sentences| == 0 then 0
    else
        var trimmed := trim(sentences[0]);
        var startsWithI := if |trimmed| > 0 then
            var words := splitBySpaces(trimmed);
            |words| > 0 && words[0] == "I"
        else false;
        (if startsWithI then 1 else 0) + CountIStartingSentences(sentences[1..])
}

function isDelimiter(c: char): bool
{
    c == '.' || c == '?' || c == '!'
}

function isWhitespace(c: char): bool
{
    c == ' ' || c == '\t' || c == '\n' || c == '\r'
}

function trim(s: string): string
    ensures |trim(s)| <= |s|
{
    var start := findFirstNonWhitespace(s, 0);
    var end := findLastNonWhitespace(s, |s| - 1);
    if start == -1 then "" else s[start..end+1]
}

function findFirstNonWhitespace(s: string, i: int): int
    requires 0 <= i <= |s|
    ensures -1 <= findFirstNonWhitespace(s, i) <= |s|
    ensures findFirstNonWhitespace(s, i) == -1 ==> forall j :: i <= j < |s| ==> isWhitespace(s[j])
    ensures findFirstNonWhitespace(s, i) != -1 ==> findFirstNonWhitespace(s, i) >= i && findFirstNonWhitespace(s, i) < |s| && !isWhitespace(s[findFirstNonWhitespace(s, i)])
    decreases |s| - i
{
    if i >= |s| then -1
    else if !isWhitespace(s[i]) then i
    else findFirstNonWhitespace(s, i + 1)
}

function findLastNonWhitespace(s: string, i: int): int
    requires -1 <= i < |s|
    ensures -1 <= findLastNonWhitespace(s, i) <= i
    ensures findLastNonWhitespace(s, i) == -1 ==> forall j :: 0 <= j <= i ==> isWhitespace(s[j])
    ensures findLastNonWhitespace(s, i) != -1 ==> findLastNonWhitespace(s, i) >= 0 && !isWhitespace(s[findLastNonWhitespace(s, i)])
    decreases i + 1
{
    if i < 0 then -1
    else if !isWhitespace(s[i]) then i
    else findLastNonWhitespace(s, i - 1)
}

function splitBySpaces(s: string): seq<string>
    ensures forall word :: word in splitBySpaces(s) ==> |word| > 0
{
    if |s| == 0 then []
    else splitBySpacesHelper(s, 0, [])
}

function splitBySpacesHelper(s: string, start: int, acc: seq<string>): seq<string>
    requires 0 <= start <= |s|
    ensures forall word :: word in splitBySpacesHelper(s, start, acc) ==> |word| > 0
    decreases |s| - start
{
    if start >= |s| then acc
    else if isWhitespace(s[start]) then
        splitBySpacesHelper(s, start + 1, acc)
    else
        var wordEnd := findNextWhitespace(s, start);
        var word := s[start..wordEnd];
        splitBySpacesHelper(s, wordEnd, acc + [word])
}

function findNextWhitespace(s: string, start: int): int
    requires 0 <= start <= |s|
    ensures start <= findNextWhitespace(s, start) <= |s|
    ensures findNextWhitespace(s, start) == |s| || isWhitespace(s[findNextWhitespace(s, start)])
    ensures forall i :: start <= i < findNextWhitespace(s, start) ==> !isWhitespace(s[i])
    decreases |s| - start
{
    if start >= |s| then |s|
    else if isWhitespace(s[start]) then start
    else findNextWhitespace(s, start + 1)
}