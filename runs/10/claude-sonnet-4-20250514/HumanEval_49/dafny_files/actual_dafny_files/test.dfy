method modp(n: int, p: int) returns (result: int)
    requires p > 0
    requires n >= 0
    ensures 0 <= result < p
{
    result := 0;
}

method {:test} test_0()
{
    var result := modp(3, 5);
    expect result == 3;
}

method {:test} test_1()
{
    var result := modp(1101, 101);
    expect result == 2;
}

method {:test} test_2()
{
    var result := modp(0, 101);
    expect result == 1;
}

method {:test} test_3()
{
    var result := modp(3, 11);
    expect result == 8;
}

method {:test} test_4()
{
    var result := modp(100, 101);
    expect result == 1;
}

method {:test} test_5()
{
    var result := modp(30, 5);
    expect result == 4;
}

method {:test} test_6()
{
    var result := modp(31, 5);
    expect result == 3;
}