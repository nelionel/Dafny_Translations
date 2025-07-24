method largest_divisor(n: int) returns (result: int)
{
    return 0;
}

method {:test} test_0()
{
    var result := largest_divisor(3);
    expect result == 1;
}

method {:test} test_1()
{
    var result := largest_divisor(7);
    expect result == 1;
}

method {:test} test_2()
{
    var result := largest_divisor(10);
    expect result == 5;
}

method {:test} test_3()
{
    var result := largest_divisor(100);
    expect result == 50;
}

method {:test} test_4()
{
    var result := largest_divisor(49);
    expect result == 7;
}