function factorial(num: int): int
{
    0
}

method special_factorial(n: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := special_factorial(4);
    expect result == 288;
}

method {:test} test_1()
{
    var result := special_factorial(5);
    expect result == 34560;
}

method {:test} test_2()
{
    var result := special_factorial(7);
    expect result == 125411328000;
}

method {:test} test_3()
{
    var result := special_factorial(1);
    expect result == 1;
}