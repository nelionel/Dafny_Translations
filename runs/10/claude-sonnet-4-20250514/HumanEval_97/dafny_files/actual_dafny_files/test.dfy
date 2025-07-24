function abs(x: int): int
{
  0
}

method multiply(a: int, b: int) returns (result: int)
{
  result := 0;
}

method {:test} test_0()
{
    var result := multiply(148, 412);
    expect result == 16;
}

method {:test} test_1()
{
    var result := multiply(19, 28);
    expect result == 72;
}

method {:test} test_2()
{
    var result := multiply(2020, 1851);
    expect result == 0;
}

method {:test} test_3()
{
    var result := multiply(14, -15);
    expect result == 20;
}

method {:test} test_4()
{
    var result := multiply(76, 67);
    expect result == 42;
}

method {:test} test_5()
{
    var result := multiply(17, 27);
    expect result == 49;
}

method {:test} test_6()
{
    var result := multiply(0, 1);
    expect result == 0;
}

method {:test} test_7()
{
    var result := multiply(0, 0);
    expect result == 0;
}