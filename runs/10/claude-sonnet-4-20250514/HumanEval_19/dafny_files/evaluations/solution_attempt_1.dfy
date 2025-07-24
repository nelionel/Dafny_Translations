method sort_numbers(numbers: string) returns (result: string)
    requires forall i :: 0 <= i < |numbers| ==> numbers[i] == ' ' || is_valid_number_word_char(numbers[i])
    requires forall word :: word in split_valid_words(numbers) ==> is_valid_number_word(word)
    ensures |numbers| == 0 ==> result == ""
    ensures is_whitespace_only(numbers) ==> result == ""
    ensures !is_whitespace_only(numbers) && |numbers| > 0 ==> 
        (var input_words := filter_empty_strings(split_string(numbers, ' '));
         var result_words := filter_empty_strings(split_string(result, ' '));
         |result_words| == |input_words| &&
         multiset(result_words) == multiset(input_words) &&
         forall i, j :: 0 <= i < j < |result_words| ==> 
             word_to_number(result_words[i]) <= word_to_number(result_words[j]))
    ensures result == "" || (result[0] != ' ' && result[|result|-1] != ' ')
    ensures forall i :: 0 <= i < |result|-1 ==> (result[i] == ' ' ==> result[i+1] != ' ')
{
    if |numbers| == 0 {
        return "";
    }
    
    // Split the string into words
    var words := split_string(numbers, ' ');
    
    // Remove empty strings from split result
    var filtered_words := filter_empty_strings(words);
    
    if |filtered_words| == 0 {
        return "";
    }
    
    // Sort the words by their numeric values
    var sorted_words := sort_word_sequence(filtered_words);
    
    // Join the sorted words back with spaces
    result := join_strings(sorted_words, " ");
}

predicate is_valid_number_word_char(c: char)
{
    c in "abcdefghijklmnopqrstuvwxyz"
}

predicate is_valid_number_word(word: string)
{
    word in {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
}

predicate is_whitespace_only(s: string)
{
    forall i :: 0 <= i < |s| ==> s[i] == ' '
}

function split_valid_words(s: string): set<string>
{
    set word | word in split_string_pure(s, ' ') && |word| > 0
}

function split_string_pure(s: string, delimiter: char): seq<string>
{
    if |s| == 0 then []
    else 
        var parts := split_string_helper(s, delimiter, 0, "");
        parts
}

function split_string_helper(s: string, delimiter: char, index: int, current: string): seq<string>
    requires 0 <= index <= |s|
    decreases |s| - index
{
    if index == |s| then [current]
    else if s[index] == delimiter then [current] + split_string_helper(s, delimiter, index + 1, "")
    else split_string_helper(s, delimiter, index + 1, current + [s[index]])
}

function word_to_number(word: string): int
{
    if word == "zero" then 0
    else if word == "one" then 1
    else if word == "two" then 2
    else if word == "three" then 3
    else if word == "four" then 4
    else if word == "five" then 5
    else if word == "six" then 6
    else if word == "seven" then 7
    else if word == "eight" then 8
    else if word == "nine" then 9
    else -1  // Invalid word, assign lowest priority
}

method split_string(s: string, delimiter: char) returns (parts: seq<string>)
    ensures forall i :: 0 <= i < |parts| ==> delimiter !in parts[i]
    decreases |s|
{
    if |s| == 0 {
        return [];
    }
    
    var result: seq<string> := [];
    var current := "";
    var i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant delimiter !in current
        invariant forall j :: 0 <= j < |result| ==> delimiter !in result[j]
        decreases |s| - i
    {
        if s[i] == delimiter {
            result := result + [current];
            current := "";
        } else {
            current := current + [s[i]];
        }
        i := i + 1;
    }
    
    result := result + [current];
    return result;
}

method filter_empty_strings(strings: seq<string>) returns (filtered: seq<string>)
    ensures forall i :: 0 <= i < |filtered| ==> |filtered[i]| > 0
    decreases |strings|
{
    if |strings| == 0 {
        return [];
    }
    
    var result: seq<string> := [];
    var i := 0;
    
    while i < |strings|
        invariant 0 <= i <= |strings|
        invariant forall j :: 0 <= j < |result| ==> |result[j]| > 0
        decreases |strings| - i
    {
        if |strings[i]| > 0 {
            result := result + [strings[i]];
        }
        i := i + 1;
    }
    
    return result;
}

method sort_word_sequence(words: seq<string>) returns (sorted_words: seq<string>)
    ensures |sorted_words| == |words|
    ensures multiset(sorted_words) == multiset(words)
    ensures forall i, j :: 0 <= i < j < |sorted_words| ==> 
        word_to_number(sorted_words[i]) <= word_to_number(sorted_words[j])
    decreases |words|
{
    if |words| <= 1 {
        return words;
    }
    
    // Simple insertion sort
    var result := [words[0]];
    var i := 1;
    
    while i < |words|
        invariant 1 <= i <= |words|
        invariant |result| == i
        invariant multiset(result) == multiset(words[0..i])
        invariant forall x, y :: 0 <= x < y < |result| ==> 
            word_to_number(result[x]) <= word_to_number(result[y])
        decreases |words| - i
    {
        var current_word := words[i];
        var current_value := word_to_number(current_word);
        
        // Find insertion position
        var pos := 0;
        while pos < |result| && word_to_number(result[pos]) <= current_value
            invariant 0 <= pos <= |result|
            decreases |result| - pos
        {
            pos := pos + 1;
        }
        
        // Insert at position pos
        result := result[0..pos] + [current_word] + result[pos..];
        i := i + 1;
    }
    
    return result;
}

method join_strings(strings: seq<string>, separator: string) returns (joined: string)
    decreases |strings|
{
    if |strings| == 0 {
        return "";
    }
    
    if |strings| == 1 {
        return strings[0];
    }
    
    var result := strings[0];
    var i := 1;
    
    while i < |strings|
        invariant 1 <= i <= |strings|
        decreases |strings| - i
    {
        result := result + separator + strings[i];
        i := i + 1;
    }
    
    return result;
}