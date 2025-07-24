method change_base(x: int, base: int) returns (result: string)
    requires x >= 0
    requires 2 <= base < 10
    ensures |result| >= 1
{
    result := "0";
}

method {:test} test_0()
{
    var result := change_base(8, 3);
    expect result == "22";
}

method {:test} test_1()
{
    var result := change_base(9, 3);
    expect result == "100";
}

method {:test} test_2()
{
    var result := change_base(234, 2);
    expect result == "11101010";
}

method {:test} test_3()
{
    var result := change_base(16, 2);
    expect result == "10000";
}

method {:test} test_4()
{
    var result := change_base(8, 2);
    expect result == "1000";
}

method {:test} test_5()
{
    var result := change_base(7, 2);
    expect result == "111";
}

method {:test} test_6()
{
    var result := change_base(2, 3);
    expect result == "2";
}

method {:test} test_7()
{
    var result := change_base(3, 4);
    expect result == "3";
}

method {:test} test_8()
{
    var result := change_base(4, 5);
    expect result == "4";
}

method {:test} test_9()
{
    var result := change_base(5, 6);
    expect result == "5";
}

method {:test} test_10()
{
    var result := change_base(6, 7);
    expect result == "6";
}

method {:test} test_11()
{
    var result := change_base(7, 8);
    expect result == "7";
}