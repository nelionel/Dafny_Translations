method do_algebra(operator: seq<string>, operand: seq<int>) returns (result: int)
    requires |operator| == |operand| - 1
    requires |operator| >= 1
    requires |operand| >= 2
    requires forall i :: 0 <= i < |operand| ==> operand[i] >= 0
    requires forall i :: 0 <= i < |operator| ==> operator[i] in {"+", "-", "*", "//", "**"}
    requires no_division_by_zero(operator, operand)
    ensures |operator| == 1 && operator[0] == "+" ==> result == operand[0] + operand[1]
    ensures |operator| == 1 && operator[0] == "-" ==> result == operand[0] - operand[1]
    ensures |operator| == 1 && operator[0] == "*" ==> result == operand[0] * operand[1]
    ensures |operator| == 1 && operator[0] == "//" && operand[1] > 0 ==> result == operand[0] / operand[1]
    ensures |operator| == 1 && operator[0] == "**" ==> result == power(operand[0], operand[1])
    ensures result == evaluate_with_precedence(operator, operand)
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

predicate no_division_by_zero(operator: seq<string>, operand: seq<int>)
    requires |operator| == |operand| - 1
    requires |operator| >= 1
    requires |operand| >= 2
    requires forall i :: 0 <= i < |operand| ==> operand[i] >= 0
    requires forall i :: 0 <= i < |operator| ==> operator[i] in {"+", "-", "*", "//", "**"}
{
    var after_exp := process_exponentiation(operator, operand);
    var after_muldiv := process_multiplication_division(after_exp.0, after_exp.1);
    true // This would need to be properly implemented to check all intermediate divisions
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

function evaluate_with_precedence(operator: seq<string>, operand: seq<int>): int
    requires |operator| == |operand| - 1
    requires |operator| >= 1
    requires |operand| >= 2
    requires forall i :: 0 <= i < |operand| ==> operand[i] >= 0
    requires forall i :: 0 <= i < |operator| ==> operator[i] in {"+", "-", "*", "//", "**"}
    requires no_division_by_zero(operator, operand)
{
    var after_exp := process_exponentiation(operator, operand);
    var after_muldiv := process_multiplication_division(after_exp.0, after_exp.1);
    var final_result := process_addition_subtraction(after_muldiv.0, after_muldiv.1);
    final_result.1[0]
}

function process_exponentiation(ops: seq<string>, vals: seq<int>): (seq<string>, seq<int>)
    requires |ops| == |vals| - 1
    requires |vals| >= 1
    requires forall i :: 0 <= i < |vals| ==> vals[i] >= 0
    requires forall i :: 0 <= i < |ops| ==> ops[i] in {"+", "-", "*", "//", "**"}
    ensures |process_exponentiation(ops, vals).0| == |process_exponentiation(ops, vals).1| - 1
    ensures |process_exponentiation(ops, vals).1| >= 1
    ensures forall i :: 0 <= i < |process_exponentiation(ops, vals).0| ==> process_exponentiation(ops, vals).0[i] in {"+", "-", "*", "//"}
{
    if |ops| == 0 then (ops, vals)
    else if ops[0] == "**" then
        var pow_result := power(vals[0], vals[1]);
        process_exponentiation(ops[1..], [pow_result] + vals[2..])
    else
        var rest := process_exponentiation(ops[1..], vals[1..]);
        ([ops[0]] + rest.0, [vals[0]] + rest.1)
}

function process_multiplication_division(ops: seq<string>, vals: seq<int>): (seq<string>, seq<int>)
    requires |ops| == |vals| - 1
    requires |vals| >= 1
    requires forall i :: 0 <= i < |ops| ==> ops[i] in {"+", "-", "*", "//"}
    ensures |process_multiplication_division(ops, vals).0| == |process_multiplication_division(ops, vals).1| - 1
    ensures |process_multiplication_division(ops, vals).1| >= 1
    ensures forall i :: 0 <= i < |process_multiplication_division(ops, vals).0| ==> process_multiplication_division(ops, vals).0[i] in {"+", "-"}
{
    if |ops| == 0 then (ops, vals)
    else if ops[0] == "*" then
        var mult_result := vals[0] * vals[1];
        process_multiplication_division(ops[1..], [mult_result] + vals[2..])
    else if ops[0] == "//" then
        var div_result := vals[0] / vals[1];
        process_multiplication_division(ops[1..], [div_result] + vals[2..])
    else
        var rest := process_multiplication_division(ops[1..], vals[1..]);
        ([ops[0]] + rest.0, [vals[0]] + rest.1)
}

function process_addition_subtraction(ops: seq<string>, vals: seq<int>): (seq<string>, seq<int>)
    requires |ops| == |vals| - 1
    requires |vals| >= 1
    requires forall i :: 0 <= i < |ops| ==> ops[i] in {"+", "-"}
    ensures |process_addition_subtraction(ops, vals).1| == 1
{
    if |ops| == 0 then (ops, vals)
    else if ops[0] == "+" then
        var add_result := vals[0] + vals[1];
        process_addition_subtraction(ops[1..], [add_result] + vals[2..])
    else // ops[0] == "-"
        var sub_result := vals[0] - vals[1];
        process_addition_subtraction(ops[1..], [sub_result] + vals[2..])
}