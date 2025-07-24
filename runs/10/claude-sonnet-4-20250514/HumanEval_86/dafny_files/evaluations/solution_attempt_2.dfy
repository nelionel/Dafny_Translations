method anti_shuffle(s: string) returns (result: string)
    ensures |result| == |s|
    ensures multiset(result) == multiset(s)
    ensures forall i :: 0 <= i < |s| ==> (s[i] == ' ' <==> result[i] == ' ')
    ensures forall i, j :: 0 <= i < j < |result| && result[i] != ' ' && result[j] != ' ' && 
            (forall k :: i < k < j ==> result[k] != ' ') ==> result[i] <= result[j]
{
    if |s| == 0 {
        return "";
    }
    
    var current_word := "";
    result := "";
    var i := 0;
    
    while i <= |s|
        invariant 0 <= i <= |s| + 1
        invariant |result| + |current_word| <= |s|
        decreases |s| + 1 - i
    {
        if i == |s| || s[i] == ' ' {
            // End of word, sort current_word and add to result
            var sorted_word := sort_string(current_word);
            result := result + sorted_word;
            if i < |s| {
                result := result + " ";
            }
            current_word := "";
        } else {
            current_word := current_word + [s[i]];
        }
        i := i + 1;
    }
}

method sort_string(word: string) returns (sorted_word: string)
    ensures |sorted_word| == |word|
    ensures multiset(sorted_word) == multiset(word)
    ensures forall i, j :: 0 <= i < j < |sorted_word| ==> sorted_word[i] <= sorted_word[j]
{
    // Convert string to sequence of characters for sorting
    var chars := seq(|word|, i requires 0 <= i < |word| => word[i]);
    var sorted_chars := sort_chars(chars);
    sorted_word := sorted_chars;
}

method sort_chars(chars: seq<char>) returns (sorted: seq<char>)
    ensures |sorted| == |chars|
    ensures forall i, j :: 0 <= i < j < |sorted| ==> sorted[i] <= sorted[j]
    ensures multiset(sorted) == multiset(chars)
{
    // Insertion sort implementation
    sorted := [];
    var i := 0;
    while i < |chars|
        invariant 0 <= i <= |chars|
        invariant |sorted| == i
        invariant forall x, y :: 0 <= x < y < |sorted| ==> sorted[x] <= sorted[y]
        invariant multiset(sorted) == multiset(chars[..i])
        decreases |chars| - i
    {
        sorted := insert_sorted(sorted, chars[i]);
        i := i + 1;
    }
}

method insert_sorted(sorted_seq: seq<char>, c: char) returns (result: seq<char>)
    requires forall i, j :: 0 <= i < j < |sorted_seq| ==> sorted_seq[i] <= sorted_seq[j]
    ensures |result| == |sorted_seq| + 1
    ensures forall i, j :: 0 <= i < j < |result| ==> result[i] <= result[j]
    ensures multiset(result) == multiset(sorted_seq) + multiset{c}
{
    var i := 0;
    while i < |sorted_seq| && sorted_seq[i] <= c
        invariant 0 <= i <= |sorted_seq|
        decreases |sorted_seq| - i
    {
        i := i + 1;
    }
    result := sorted_seq[..i] + [c] + sorted_seq[i..];
}