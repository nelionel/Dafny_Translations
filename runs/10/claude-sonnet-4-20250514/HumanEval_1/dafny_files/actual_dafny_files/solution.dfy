method separate_paren_groups(paren_string: string) returns (result: seq<string>)
    requires forall i :: 0 <= i < |paren_string| ==> paren_string[i] in {'(', ')', ' '}
    requires is_balanced(remove_spaces(paren_string))
    ensures |result| >= 0
    ensures forall i :: 0 <= i < |result| ==> |result[i]| > 0
    ensures forall i :: 0 <= i < |result| ==> |result[i]| >= 2
    ensures forall i :: 0 <= i < |result| ==> result[i][0] == '(' && result[i][|result[i]|-1] == ')'
    ensures forall i :: 0 <= i < |result| ==> is_balanced(result[i])
    ensures forall i :: 0 <= i < |result| ==> forall j :: 0 <= j < |result[i]| ==> result[i][j] in {'(', ')'}
    ensures concat_groups(result) == remove_spaces(paren_string)
{
    // Remove spaces from input string
    var cleaned := "";
    var i := 0;
    while i < |paren_string|
        invariant 0 <= i <= |paren_string|
        invariant forall j :: 0 <= j < |cleaned| ==> cleaned[j] != ' '
        decreases |paren_string| - i
    {
        if paren_string[i] != ' ' {
            cleaned := cleaned + [paren_string[i]];
        }
        i := i + 1;
    }
    
    result := [];
    var current_group := "";
    var balance := 0;
    var j := 0;
    
    while j < |cleaned|
        invariant 0 <= j <= |cleaned|
        invariant balance >= 0
        invariant balance == 0 ==> current_group == ""
        invariant forall k :: 0 <= k < |result| ==> |result[k]| > 0
        decreases |cleaned| - j
    {
        if cleaned[j] == '(' {
            balance := balance + 1;
            current_group := current_group + [cleaned[j]];
        } else if cleaned[j] == ')' {
            balance := balance - 1;
            current_group := current_group + [cleaned[j]];
            
            if balance == 0 {
                result := result + [current_group];
                current_group := "";
            }
        }
        j := j + 1;
    }
}

function remove_spaces(s: string): string
{
    if |s| == 0 then ""
    else if s[0] == ' ' then remove_spaces(s[1..])
    else [s[0]] + remove_spaces(s[1..])
}

function is_balanced(s: string): bool
{
    is_balanced_helper(s, 0)
}

function is_balanced_helper(s: string, balance: int): bool
{
    if balance < 0 then false
    else if |s| == 0 then balance == 0
    else if s[0] == '(' then is_balanced_helper(s[1..], balance + 1)
    else if s[0] == ')' then is_balanced_helper(s[1..], balance - 1)
    else is_balanced_helper(s[1..], balance)
}

function concat_groups(groups: seq<string>): string
{
    if |groups| == 0 then ""
    else groups[0] + concat_groups(groups[1..])
}