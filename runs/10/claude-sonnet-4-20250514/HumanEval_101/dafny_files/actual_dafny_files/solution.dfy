method words_string(s: string) returns (result: seq<string>)
    ensures forall word :: word in result ==> |word| > 0
    ensures (|s| == 0 || (forall i :: 0 <= i < |s| ==> (s[i] == ' ' || s[i] == ',' || s[i] == '\t' || s[i] == '\n' || s[i] == '\r'))) ==> |result| == 0
    ensures |result| == 0 ==> (|s| == 0 || (forall i :: 0 <= i < |s| ==> (s[i] == ' ' || s[i] == ',' || s[i] == '\t' || s[i] == '\n' || s[i] == '\r')))
    ensures forall word :: word in result ==> (forall i :: 0 <= i < |word| ==> word[i] != ' ' && word[i] != ',' && word[i] != '\t' && word[i] != '\n' && word[i] != '\r')
    ensures |result| > 0 ==> exists i :: 0 <= i < |s| && s[i] != ' ' && s[i] != ',' && s[i] != '\t' && s[i] != '\n' && s[i] != '\r'
{
    if |s| == 0 {
        return [];
    }
    
    // Check if string contains only whitespace and commas
    var has_non_separator := false;
    var i := 0;
    while i < |s|
        invariant 0 <= i <= |s|
        invariant has_non_separator <==> exists j :: 0 <= j < i && s[j] != ' ' && s[j] != ',' && s[j] != '\t' && s[j] != '\n' && s[j] != '\r'
        decreases |s| - i
    {
        if s[i] != ' ' && s[i] != ',' && s[i] != '\t' && s[i] != '\n' && s[i] != '\r' {
            has_non_separator := true;
            break;
        }
        i := i + 1;
    }
    
    if !has_non_separator {
        return [];
    }
    
    // Split the string into words
    result := [];
    var current_word := "";
    i := 0;
    
    while i < |s|
        invariant 0 <= i <= |s|
        invariant forall word :: word in result ==> |word| > 0
        decreases |s| - i
    {
        var ch := s[i];
        if ch == ' ' || ch == ',' || ch == '\t' || ch == '\n' || ch == '\r' {
            // Found a separator
            if |current_word| > 0 {
                result := result + [current_word];
                current_word := "";
            }
        } else {
            // Add character to current word
            current_word := current_word + [ch];
        }
        i := i + 1;
    }
    
    // Add the last word if it exists
    if |current_word| > 0 {
        result := result + [current_word];
    }
}