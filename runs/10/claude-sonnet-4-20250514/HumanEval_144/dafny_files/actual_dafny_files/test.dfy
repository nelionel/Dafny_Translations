method simplify(x: string, n: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := simplify("1/5", "5/1");
    expect result == true;
}

method {:test} test_1()
{
    var result := simplify("1/6", "2/1");
    expect result == false;
}

method {:test} test_2()
{
    var result := simplify("5/1", "3/1");
    expect result == true;
}

method {:test} test_3()
{
    var result := simplify("7/10", "10/2");
    expect result == false;
}

method {:test} test_4()
{
    var result := simplify("2/10", "50/10");
    expect result == true;
}

method {:test} test_5()
{
    var result := simplify("7/2", "4/2");
    expect result == true;
}

method {:test} test_6()
{
    var result := simplify("11/6", "6/1");
    expect result == true;
}

method {:test} test_7()
{
    var result := simplify("2/3", "5/2");
    expect result == false;
}

method {:test} test_8()
{
    var result := simplify("5/2", "3/5");
    expect result == false;
}

method {:test} test_9()
{
    var result := simplify("2/4", "8/4");
    expect result == true;
}

method {:test} test_10()
{
    var result := simplify("2/4", "4/2");
    expect result == true;
}

method {:test} test_11()
{
    var result := simplify("1/5", "5/1");
    expect result == true;
}

method {:test} test_12()
{
    var result := simplify("1/5", "1/5");
    expect result == false;
}