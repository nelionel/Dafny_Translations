method sort_third(l: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result1 := sort_third([1, 2, 3]);
    var result2 := sort_third([1, 2, 3]);
    expect result1 == result2;
}

method {:test} test_1()
{
    var result1 := sort_third([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10]);
    var result2 := sort_third([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10]);
    expect result1 == result2;
}

method {:test} test_2()
{
    var result1 := sort_third([5, 8, -12, 4, 23, 2, 3, 11, 12, -10]);
    var result2 := sort_third([5, 8, -12, 4, 23, 2, 3, 11, 12, -10]);
    expect result1 == result2;
}

method {:test} test_3()
{
    var result := sort_third([5, 6, 3, 4, 8, 9, 2]);
    expect result == [2, 6, 3, 4, 8, 9, 5];
}

method {:test} test_4()
{
    var result := sort_third([5, 8, 3, 4, 6, 9, 2]);
    expect result == [2, 8, 3, 4, 6, 9, 5];
}

method {:test} test_5()
{
    var result := sort_third([5, 6, 9, 4, 8, 3, 2]);
    expect result == [2, 6, 9, 4, 8, 3, 5];
}

method {:test} test_6()
{
    var result := sort_third([5, 6, 3, 4, 8, 9, 2, 1]);
    expect result == [2, 6, 3, 4, 8, 9, 5, 1];
}