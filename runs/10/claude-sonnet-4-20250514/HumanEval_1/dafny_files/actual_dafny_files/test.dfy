method separate_paren_groups(paren_string: string) returns (result: seq<string>)
    ensures |result| >= 0
    ensures forall i :: 0 <= i < |result| ==> |result[i]| > 0
{
    result := [];
}

method {:test} test_0()
{
    var result := separate_paren_groups("(()()) ((())) () ((())()())");
    expect result == ["(()())", "((()))", "()", "((())()())"];
}

method {:test} test_1()
{
    var result := separate_paren_groups("() (()) ((())) (((())))");
    expect result == ["()", "(())", "((()))", "(((()))"];
}

method {:test} test_2()
{
    var result := separate_paren_groups("(()(())((())))");
    expect result == ["(()(())((()))"];
}

method {:test} test_3()
{
    var result := separate_paren_groups("( ) (( )) (( )( ))");
    expect result == ["()", "(())", "(()())"];
}