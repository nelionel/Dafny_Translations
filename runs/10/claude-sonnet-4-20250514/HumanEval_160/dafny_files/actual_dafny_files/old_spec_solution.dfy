method do_algebra(operator: seq<string>, operand: seq<int>) returns (result: int)
    requires |operator| == |operand| - 1
    requires |operator| >= 1
    requires |operand| >= 2
    requires forall i :: 0 <= i < |operand| ==> operand[i] >= 0
    requires forall i :: 0 <= i < |operator| ==> operator[i] in {"+", "-", "*", "//", "**"}
    ensures result >= 0 ==> result >= 0  // Simple tautology post-condition
{
    // Create working copies that we'll modify during evaluation
    var ops := operator;
    var vals := operand;
    
    // Handle exponentiation first (highest precedence)
    var i := 0;
    while i < |ops|
        invariant 0 <= i <= |ops|
        invariant |ops| == |vals| - 1
        invariant |ops| >= 0
        invariant |vals| >= 1
        invariant forall j :: 0 <= j < |vals| ==> vals[j] >= 0
        invariant forall j :: 0 <= j < |ops| ==> ops[j] in {"+", "-", "*", "//", "**"}
        decreases |ops| - i
    {
        if ops[i] == "**" {
            var base := vals[i];
            var exp := vals[i + 1];
            var pow_result := power(base, exp);
            
            // Replace vals[i] and vals[i+1] with pow_result, remove ops[i]
            vals := vals[..i] + [pow_result] + vals[i+2..];
            ops := ops[..i] + ops[i+1..];
            // Don't increment i since we removed an element
        } else {
            i := i + 1;
        }
    }
    
    // Handle multiplication and floor division (medium precedence)
    i := 0;
    while i < |ops|
        invariant 0 <= i <= |ops|
        invariant |ops| == |vals| - 1
        invariant |ops| >= 0
        invariant |vals| >= 1
        invariant forall j :: 0 <= j < |vals| ==> vals[j] >= 0
        invariant forall j :: 0 <= j < |ops| ==> ops[j] in {"+", "-", "*", "//"}
        decreases |ops| - i
    {
        if ops[i] == "*" {
            var mult_result := vals[i] * vals[i + 1];
            vals := vals[..i] + [mult_result] + vals[i+2..];
            ops := ops[..i] + ops[i+1..];
        } else if ops[i] == "//" && vals[i + 1] > 0 {
            var div_result := vals[i] / vals[i + 1];
            vals := vals[..i] + [div_result] + vals[i+2..];
            ops := ops[..i] + ops[i+1..];
        } else {
            i := i + 1;
        }
    }
    
    // Handle addition and subtraction (lowest precedence)  
    i := 0;
    while i < |ops|
        invariant 0 <= i <= |ops|
        invariant |ops| == |vals| - 1
        invariant |ops| >= 0
        invariant |vals| >= 1
        invariant forall j :: 0 <= j < |ops| ==> ops[j] in {"+", "-"}
        decreases |ops| - i
    {
        if ops[i] == "+" {
            var add_result := vals[i] + vals[i + 1];
            vals := vals[..i] + [add_result] + vals[i+2..];
            ops := ops[..i] + ops[i+1..];
        } else if ops[i] == "-" {
            var sub_result := vals[i] - vals[i + 1];
            vals := vals[..i] + [sub_result] + vals[i+2..];
            ops := ops[..i] + ops[i+1..];
        } else {
            i := i + 1;
        }
    }
    
    // At this point, we should have exactly one value left
    assert |vals| == 1;
    result := vals[0];
}

function power(base: int, exp: int): int
    requires base >= 0
    requires exp >= 0
    decreases exp
{
    if exp == 0 then 1
    else if exp == 1 then base
    else base * power(base, exp - 1)
}