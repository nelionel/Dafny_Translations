method count_nums(arr: seq<int>) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := count_nums([]);
    expect result == 0;
}

method {:test} test_1()
{
    var result := count_nums([-1, -2, 0]);
    expect result == 0;
}

method {:test} test_2()
{
    var result := count_nums([1, 1, 2, -2, 3, 4, 5]);
    expect result == 6;
}

method {:test} test_3()
{
    var result := count_nums([1, 6, 9, -6, 0, 1, 5]);
    expect result == 5;
}

method {:test} test_4()
{
    var result := count_nums([1, 100, 98, -7, 1, -1]);
    expect result == 4;
}

method {:test} test_5()
{
    var result := count_nums([12, 23, 34, -45, -56, 0]);
    expect result == 5;
}

method {:test} test_6()
{
    var result := count_nums([0, 1]);
    expect result == 1;
}

method {:test} test_7()
{
    var result := count_nums([1]);
    expect result == 1;
}