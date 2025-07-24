method parse_nested_parens(paren_string: string) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := parse_nested_parens("(()()) ((())) () ((())()())");
    expect result == [2, 3, 1, 3];
}

method {:test} test_1()
{
    var result := parse_nested_parens("() (()) ((())) (((())))");
    expect result == [1, 2, 3, 4];
}

method {:test} test_2()
{
    var result := parse_nested_parens("(()(())((())))");
    expect result == [4];
}