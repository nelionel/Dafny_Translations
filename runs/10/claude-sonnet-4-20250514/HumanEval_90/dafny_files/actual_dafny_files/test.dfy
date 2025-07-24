method next_smallest(lst: seq<int>) returns (result: int)
{
    return 0;
}

method {:test} test_0()
{
    var result := next_smallest([1, 2, 3, 4, 5]);
    expect result == 2;
}

method {:test} test_1()
{
    var result := next_smallest([5, 1, 4, 3, 2]);
    expect result == 2;
}

method {:test} test_2()
{
    var result := next_smallest([]);
    expect result == -1;
}

method {:test} test_3()
{
    var result := next_smallest([1, 1]);
    expect result == -1;
}

method {:test} test_4()
{
    var result := next_smallest([1, 1, 1, 1, 0]);
    expect result == 1;
}

method {:test} test_5()
{
    var result := next_smallest([1, 1]); // 0**0 = 1, so [1, 1]
    expect result == -1;
}

method {:test} test_6()
{
    var result := next_smallest([-35, 34, 12, -45]);
    expect result == -35;
}