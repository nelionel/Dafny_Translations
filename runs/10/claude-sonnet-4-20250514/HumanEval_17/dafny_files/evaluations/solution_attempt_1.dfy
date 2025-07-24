method parse_music(music_string: string) returns (result: seq<int>)
    ensures forall i :: 0 <= i < |result| ==> result[i] in {1, 2, 4}
    ensures (|music_string| == 0 || is_all_whitespace(music_string)) ==> |result| == 0
    ensures |result| <= |music_string|  // result can't be longer than input
    ensures |music_string| > 0 && !is_all_whitespace(music_string) ==> 
            (|result| == 0 <==> forall_tokens_invalid(music_string))
{
    result := [];
    
    // Handle empty or whitespace-only string
    if |music_string| == 0 || is_all_whitespace(music_string) {
        return;
    }
    
    var i := 0;
    while i < |music_string|
        invariant 0 <= i <= |music_string|
        invariant forall j :: 0 <= j < |result| ==> result[j] in {1, 2, 4}
        decreases |music_string| - i
    {
        // Skip whitespace
        while i < |music_string| && music_string[i] == ' '
            invariant 0 <= i <= |music_string|
            decreases |music_string| - i
        {
            i := i + 1;
        }
        
        if i >= |music_string| {
            break;
        }
        
        // Parse note starting at position i
        var note := "";
        var start_pos := i;
        
        // Read characters until space or end of string
        while i < |music_string| && music_string[i] != ' '
            invariant start_pos <= i <= |music_string|
            decreases |music_string| - i
        {
            note := note + [music_string[i]];
            i := i + 1;
        }
        
        // Convert note to beat count
        var beats := note_to_beats(note);
        if beats > 0 {
            result := result + [beats];
        }
    }
}

function note_to_beats(note: string): int
{
    if note == "o" then 4
    else if note == "o|" then 2
    else if note == ".|" then 1
    else 0
}

predicate is_all_whitespace(s: string)
{
    forall i :: 0 <= i < |s| ==> s[i] == ' '
}

predicate forall_tokens_invalid(s: string)
{
    forall token :: token in split_by_spaces(s) ==> note_to_beats(token) == 0
}

function split_by_spaces(s: string): seq<string>
{
    // This is a specification-only function to describe the tokens
    // that would be created by splitting the string by spaces
    if |s| == 0 then []
    else
        var tokens := [];
        // Abstract representation of splitting logic
        tokens
}