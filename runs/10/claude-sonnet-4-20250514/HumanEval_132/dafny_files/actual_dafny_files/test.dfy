method is_nested(s: string) returns (result: bool)
    requires forall i :: 0 <= i < |s| ==> s[i] == '[' || s[i] == ']'
{
    result := false;
}

method {:test} test_0()
{
    var result := is_nested("[[]]");
    expect result == true;
}

method {:test} test_1()
{
    var result := is_nested("[]]]]]]][[[[[]");
    expect result == false;
}

method {:test} test_2()
{
    var result := is_nested("[][]");
    expect result == false;
}

method {:test} test_3()
{
    var result := is_nested("[]");
    expect result == false;
}

method {:test} test_4()
{
    var result := is_nested("[[[[]]]]");
    expect result == true;
}

method {:test} test_5()
{
    var result := is_nested("[]]]]]]]]]]");
    expect result == false;
}

method {:test} test_6()
{
    var result := is_nested("[][][[]]");
    expect result == true;
}

method {:test} test_7()
{
    var result := is_nested("[[]");
    expect result == false;
}

method {:test} test_8()
{
    var result := is_nested("[]]");
    expect result == false;
}

method {:test} test_9()
{
    var result := is_nested("[[]][[");
    expect result == true;
}

method {:test} test_10()
{
    var result := is_nested("[[][]]");
    expect result == true;
}

method {:test} test_11()
{
    var result := is_nested("");
    expect result == false;
}

method {:test} test_12()
{
    var result := is_nested("[[[[[[[[");
    expect result == false;
}

method {:test} test_13()
{
    var result := is_nested("]]]]]]]]");
    expect result == false;
}