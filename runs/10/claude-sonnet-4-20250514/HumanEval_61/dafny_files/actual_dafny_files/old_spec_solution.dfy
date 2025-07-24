method correct_bracketing(brackets: string) returns (result: bool)
{
    var count := 0;
    var i := 0;
    
    while i < |brackets|
        invariant 0 <= i <= |brackets|
        invariant count >= 0
        decreases |brackets| - i
    {
        if brackets[i] == '(' {
            count := count + 1;
        } else if brackets[i] == ')' {
            count := count - 1;
            if count < 0 {
                return false;
            }
        }
        i := i + 1;
    }
    
    result := count == 0;
}