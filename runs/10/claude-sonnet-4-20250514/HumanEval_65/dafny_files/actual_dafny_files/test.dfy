method circular_shift(x: int, shift: int) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := circular_shift(100, 2);
    expect result == "001";
}

method {:test} test_1()
{
    var result := circular_shift(12, 2);
    expect result == "12";
}

method {:test} test_2()
{
    var result := circular_shift(97, 8);
    expect result == "79";
}

method {:test} test_3()
{
    var result := circular_shift(12, 1);
    expect result == "21";
}

method {:test} test_4()
{
    var result := circular_shift(11, 101);
    expect result == "11";
}