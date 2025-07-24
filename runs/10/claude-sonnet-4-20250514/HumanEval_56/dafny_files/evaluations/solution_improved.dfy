method correct_bracketing(brackets: string) returns (result: bool)
    requires forall i :: 0 <= i < |brackets| ==> brackets[i] == '<' || brackets[i] == '>'
    ensures result == (forall i :: 0 <= i <= |brackets| ==> 
        |set j | 0 <= j < i && brackets[j] == '<'| >= |set j | 0 <= j < i && brackets[j] == '>'|) &&
        |set j | 0 <= j < |brackets| && brackets[j] == '<'| == |set j | 0 <= j < |brackets| && brackets[j] == '>'|
{
    var counter := 0;
    var i := 0;
    
    while i < |brackets|
        invariant 0 <= i <= |brackets|
        invariant counter >= 0
        invariant counter == |set j | 0 <= j < i && brackets[j] == '<'| - |set j | 0 <= j < i && brackets[j] == '>'|
        decreases |brackets| - i
    {
        if brackets[i] == '<' {
            counter := counter + 1;
        } else if brackets[i] == '>' {
            counter := counter - 1;
            if counter < 0 {
                return false;
            }
        }
        i := i + 1;
    }
    
    return counter == 0;
}