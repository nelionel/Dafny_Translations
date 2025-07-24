method has_close_elements(numbers: seq<real>, threshold: real) returns (result: bool)
    ensures result <==> exists i, j :: 0 <= i < |numbers| && 0 <= j < |numbers| && i != j && 
                                      abs_real(numbers[i] - numbers[j]) < threshold
{
    result := false;
    
    var i := 0;
    while i < |numbers|
        invariant 0 <= i <= |numbers|
        invariant result ==> exists x, y :: 0 <= x < |numbers| && 0 <= y < |numbers| && x != y && 
                                           abs_real(numbers[x] - numbers[y]) < threshold
        decreases |numbers| - i
    {
        var j := i + 1;
        while j < |numbers|
            invariant i + 1 <= j <= |numbers|
            invariant result ==> exists x, y :: 0 <= x < |numbers| && 0 <= y < |numbers| && x != y && 
                                               abs_real(numbers[x] - numbers[y]) < threshold
            decreases |numbers| - j
        {
            var diff := numbers[i] - numbers[j];
            var abs_diff := if diff >= 0.0 then diff else -diff;
            if abs_diff < threshold {
                result := true;
                return;
            }
            j := j + 1;
        }
        i := i + 1;
    }
}

function abs_real(x: real): real
{
    if x >= 0.0 then x else -x
}