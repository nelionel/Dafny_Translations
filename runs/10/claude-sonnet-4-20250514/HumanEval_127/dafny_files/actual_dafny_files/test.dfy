method intersection(start1: int, end1: int, start2: int, end2: int) returns (result: string)
{
    result := "NO";
}

method {:test} test_0()
{
    var result := intersection(1, 2, 2, 3);
    expect result == "NO";
}

method {:test} test_1()
{
    var result := intersection(-1, 1, 0, 4);
    expect result == "NO";
}

method {:test} test_2()
{
    var result := intersection(-3, -1, -5, 5);
    expect result == "YES";
}

method {:test} test_3()
{
    var result := intersection(-2, 2, -4, 0);
    expect result == "YES";
}

method {:test} test_4()
{
    var result := intersection(-11, 2, -1, -1);
    expect result == "NO";
}

method {:test} test_5()
{
    var result := intersection(1, 2, 3, 5);
    expect result == "NO";
}

method {:test} test_6()
{
    var result := intersection(1, 2, 1, 2);
    expect result == "NO";
}

method {:test} test_7()
{
    var result := intersection(-2, -2, -3, -2);
    expect result == "NO";
}