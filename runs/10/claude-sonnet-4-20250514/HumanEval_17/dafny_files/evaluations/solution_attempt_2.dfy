method parse_music(music_string: string) returns (result: seq<int>)
    ensures forall i :: 0 <= i < |result| ==> result[i] in {1, 2, 4}
    ensures (|music_string| == 0 || is_all_whitespace(music_string)) ==> |result| == 0
    ensures |result| <= |music_string|  // result can't be longer than input
    ensures forall beats :: beats in result ==> exists token :: token in split_tokens(music_string) && note_to_beats(token) == beats
    ensures forall token :: token in split_tokens(music_string) && note_to_beats(token) > 0 ==> note_to_beats(token) in result
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

function split_tokens(s: string): seq<string>
    decreases |s|
{
    if |s| == 0 then []
    else if is_all_whitespace(s) then []
    else
        var first_token := extract_first_token(s);
        var rest_start := skip_token_and_spaces(s, 0);
        if rest_start >= |s| then [first_token]
        else [first_token] + split_tokens(s[rest_start..])
}

function extract_first_token(s: string): string
    requires |s| > 0 && !is_all_whitespace(s)
{
    var start := skip_spaces(s, 0);
    if start >= |s| then ""
    else
        var end := find_next_space(s, start);
        s[start..end]
}

function skip_spaces(s: string, pos: int): int
    requires 0 <= pos <= |s|
    ensures skip_spaces(s, pos) <= |s|
    decreases |s| - pos
{
    if pos >= |s| || s[pos] != ' ' then pos
    else skip_spaces(s, pos + 1)
}

function find_next_space(s: string, pos: int): int
    requires 0 <= pos <= |s|
    ensures pos <= find_next_space(s, pos) <= |s|
    decreases |s| - pos
{
    if pos >= |s| || s[pos] == ' ' then pos
    else find_next_space(s, pos + 1)
}

function skip_token_and_spaces(s: string, pos: int): int
    requires 0 <= pos <= |s|
    ensures skip_token_and_spaces(s, pos) <= |s|
    decreases |s| - pos
{
    var after_spaces := skip_spaces(s, pos);
    if after_spaces >= |s| then |s|
    else
        var after_token := find_next_space(s, after_spaces);
        skip_spaces(s, after_token)
}