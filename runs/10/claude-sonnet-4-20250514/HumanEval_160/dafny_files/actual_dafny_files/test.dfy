method do_algebra(operator: seq<string>, operand: seq<int>) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := do_algebra(["**", "*", "+"], [2, 3, 4, 5]);
    expect result == 37;
}

method {:test} test_1()
{
    var result := do_algebra(["+", "*", "-"], [2, 3, 4, 5]);
    expect result == 9;
}

method {:test} test_2()
{
    var result := do_algebra(["//", "*"], [7, 3, 4]);
    expect result == 8;
}

method {:test} test_3()
{
    // This corresponds to "assert True" which is always true
    expect true;
}