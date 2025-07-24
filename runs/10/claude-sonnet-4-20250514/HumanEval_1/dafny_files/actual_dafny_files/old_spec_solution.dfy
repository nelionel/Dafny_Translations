method separate_paren_groups(paren_string: string) returns (result: seq<string>)
    ensures |result| >= 0
    ensures forall i :: 0 <= i < |result| ==> |result[i]| > 0
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