method correct_bracketing(brackets: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := correct_bracketing("()");
    expect result == true;
}

method {:test} test_1()
{
    var result := correct_bracketing("(()())");
    expect result == true;
}

method {:test} test_2()
{
    var result := correct_bracketing("()()(()())()");
    expect result == true;
}

method {:test} test_3()
{
    var result := correct_bracketing("()()((()()())())(()()(()))");
    expect result == true;
}

method {:test} test_4()
{
    var result := correct_bracketing("((()()))");
    expect result == false;
}

method {:test} test_5()
{
    var result := correct_bracketing(")(()");
    expect result == false;
}

method {:test} test_6()
{
    var result := correct_bracketing("(");
    expect result == false;
}

method {:test} test_7()
{
    var result := correct_bracketing("((((");
    expect result == false;
}

method {:test} test_8()
{
    var result := correct_bracketing(")");
    expect result == false;
}

method {:test} test_9()
{
    var result := correct_bracketing("(()");
    expect result == false;
}

method {:test} test_10()
{
    var result := correct_bracketing("()()(()())())(()");
    expect result == false;
}

method {:test} test_11()
{
    var result := correct_bracketing("()()(()())()))()");
    expect result == false;
}