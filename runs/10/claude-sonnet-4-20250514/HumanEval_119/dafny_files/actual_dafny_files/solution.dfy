method match_parens(lst: seq<string>) returns (result: string)
    requires |lst| == 2
    requires forall i :: 0 <= i < |lst| ==> forall j :: 0 <= j < |lst[i]| ==> lst[i][j] == '(' || lst[i][j] == ')'
    ensures result == "Yes" || result == "No"
{
    var option1 := lst[0] + lst[1];
    var option2 := lst[1] + lst[0];
    
    if is_balanced(option1) || is_balanced(option2) {
        result := "Yes";
    } else {
        result := "No";
    }
}

function is_balanced(s: string): bool
    requires forall i :: 0 <= i < |s| ==> s[i] == '(' || s[i] == ')'
{
    is_balanced_helper(s, 0, 0)
}

function is_balanced_helper(s: string, index: int, counter: int): bool
    requires forall i :: 0 <= i < |s| ==> s[i] == '(' || s[i] == ')'
    requires 0 <= index <= |s|
    requires counter >= 0
    decreases |s| - index
{
    if index == |s| then
        counter == 0
    else if s[index] == '(' then
        is_balanced_helper(s, index + 1, counter + 1)
    else // s[index] == ')'
        if counter == 0 then
            false
        else
            is_balanced_helper(s, index + 1, counter - 1)
}