method parse_nested_parens(paren_string: string) returns (result: seq<int>)
    ensures |result| >= 0
    ensures forall i :: 0 <= i < |result| ==> result[i] >= 0
{
    var groups := split_by_spaces(paren_string);
    result := [];
    
    var i := 0;
    while i < |groups|
        invariant 0 <= i <= |groups|
        invariant |result| == i
        invariant forall j :: 0 <= j < i ==> result[j] >= 0
        decreases |groups| - i
    {
        var max_depth := calculate_max_depth(groups[i]);
        result := result + [max_depth];
        i := i + 1;
    }
}

method split_by_spaces(s: string) returns (groups: seq<string>)
    ensures |groups| >= 0
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
{
    var current_depth := 0;
    max_depth := 0;
    
    var i := 0;
    while i < |group|
        invariant 0 <= i <= |group|
        invariant current_depth >= 0
        invariant max_depth >= 0
        invariant max_depth >= current_depth
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