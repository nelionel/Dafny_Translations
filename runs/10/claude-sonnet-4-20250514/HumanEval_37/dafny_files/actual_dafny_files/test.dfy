method sort_even(l: seq<int>) returns (result: seq<int>)
{
    result := l;
}

method {:test} test_0()
{
    var result := sort_even([1, 2, 3]);
    expect result == [1, 2, 3];
}

method {:test} test_1()
{
    var result := sort_even([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10]);
    expect result == [-10, 3, -5, 2, -3, 3, 5, 0, 9, 1, 123];
}

method {:test} test_2()
{
    var result := sort_even([5, 8, -12, 4, 23, 2, 3, 11, 12, -10]);
    expect result == [-12, 8, 3, 4, 5, 2, 12, 11, 23, -10];
}