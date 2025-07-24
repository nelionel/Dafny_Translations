method greatest_common_divisor(a: int, b: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := greatest_common_divisor(3, 7);
    expect result == 1;
}

method {:test} test_1()
{
    var result := greatest_common_divisor(10, 15);
    expect result == 5;
}

method {:test} test_2()
{
    var result := greatest_common_divisor(49, 14);
    expect result == 7;
}

method {:test} test_3()
{
    var result := greatest_common_divisor(144, 60);
    expect result == 12;
}