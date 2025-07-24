method parse_nested_parens(paren_string: string) returns (result: seq<int>)
    ensures |result| >= 0
    ensures forall i :: 0 <= i < |result| ==> result[i] >= 0
    ensures var groups := split_by_spaces_spec(paren_string); |result| == |groups|
    ensures var groups := split_by_spaces_spec(paren_string); forall i :: 0 <= i < |result| ==> result[i] == calculate_max_depth_spec(groups[i])
{
    var groups := split_by_spaces(paren_string);
    result := [];
    
    var i := 0;
    while i < |groups|
        invariant 0 <= i <= |groups|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> result[j] >= 0
        invariant forall j :: 0 <= j < i ==> result[j] == calculate_max_depth_spec(groups[j])
        decreases |groups| - i
    {
        var max_depth := calculate_max_depth(groups[i]);
        result := result + [max_depth];
        i := i + 1;
    }
}

function split_by_spaces_spec(s: string): seq<string>
{
    if |s| == 0 then []
    else
        var trimmed := trim_spaces(s);
        if |trimmed| == 0 then []
        else split_non_empty(trimmed)
}

function trim_spaces(s: string): string
{
    if |s| == 0 then s
    else if s[0] == ' ' then trim_spaces(s[1..])
    else if s[|s|-1] == ' ' then trim_spaces(s[..|s|-1])
    else s
}

function split_non_empty(s: string): seq<string>
    requires |s| > 0
    requires s[0] != ' ' && s[|s|-1] != ' '
{
    if ' ' !in s then [s]
    else
        var space_pos := find_space(s, 0);
        [s[..space_pos]] + split_by_spaces_spec(s[space_pos+1..])
}

function find_space(s: string, start: int): int
    requires 0 <= start < |s|
    requires ' ' in s[start..]
    ensures start <= find_space(s, start) < |s|
    ensures s[find_space(s, start)] == ' '
{
    if s[start] == ' ' then start
    else find_space(s, start + 1)
}

function calculate_max_depth_spec(group: string): int
    ensures calculate_max_depth_spec(group) >= 0
{
    calculate_max_depth_helper(group, 0, 0, 0)
}

function calculate_max_depth_helper(group: string, index: int, current_depth: int, max_depth: int): int
    requires 0 <= index <= |group|
    requires current_depth >= 0
    requires max_depth >= 0
    ensures calculate_max_depth_helper(group, index, current_depth, max_depth) >= 0
{
    if index == |group| then max_depth
    else if group[index] == '(' then
        var new_depth := current_depth + 1;
        calculate_max_depth_helper(group, index + 1, new_depth, if new_depth > max_depth then new_depth else max_depth)
    else if group[index] == ')' then
        calculate_max_depth_helper(group, index + 1, if current_depth > 0 then current_depth - 1 else 0, max_depth)
    else
        calculate_max_depth_helper(group, index + 1, current_depth, max_depth)
}

method split_by_spaces(s: string) returns (groups: seq<string>)
    ensures |groups| >= 0
    ensures groups == split_by_spaces_spec(s)
{
    groups := [];
    if |s| == 0 {
        return;
    }
    
    var start := 0;
    var i := 0;
    
    // Skip leading spaces
    while i < |s| && s[i] == ' '
        invariant 0 <= i <= |s|
        decreases |s| - i
    {
        i := i + 1;
    }
    
    start := i;
    
    while i <= |s|
        invariant start <= i <= |s|
        invariant start <= |s|
        decreases |s| - i + 1
    {
        if i == |s| || s[i] == ' ' {
            if start < i {
                groups := groups + [s[start..i]];
            }
            // Skip spaces
            while i < |s| && s[i] == ' '
                invariant start <= i <= |s|
                decreases |s| - i
            {
                i := i + 1;
            }
            start := i;
        } else {
            i := i + 1;
        }
    }
}

method calculate_max_depth(group: string) returns (max_depth: int)
    ensures max_depth >= 0
    ensures max_depth == calculate_max_depth_spec(group)
{
    var current_depth := 0;
    max_depth := 0;
    
    var i := 0;
    while i < |group|
        invariant 0 <= i <= |group|
        invariant current_depth >= 0
        invariant max_depth >= 0
        invariant max_depth >= current_depth
        invariant max_depth == calculate_max_depth_helper(group, i, current_depth, max_depth)
        decreases |group| - i
    {
        if group[i] == '(' {
            current_depth := current_depth + 1;
            if current_depth > max_depth {
                max_depth := current_depth;
            }
        } else if group[i] == ')' {
            if current_depth > 0 {
                current_depth := current_depth - 1;
            }
        }
        i := i + 1;
    }
}