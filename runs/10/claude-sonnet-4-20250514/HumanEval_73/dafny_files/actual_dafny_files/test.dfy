method smallest_change(arr: seq<int>) returns (changes: int)
{
    changes := 0;
}

method {:test} test_0()
{
    var result := smallest_change([1,2,3,5,4,7,9,6]);
    expect result == 4;
}

method {:test} test_1()
{
    var result := smallest_change([1, 2, 3, 4, 3, 2, 2]);
    expect result == 1;
}

method {:test} test_2()
{
    var result := smallest_change([1, 4, 2]);
    expect result == 1;
}

method {:test} test_3()
{
    var result := smallest_change([1, 4, 4, 2]);
    expect result == 1;
}

method {:test} test_4()
{
    var result := smallest_change([1, 2, 3, 2, 1]);
    expect result == 0;
}

method {:test} test_5()
{
    var result := smallest_change([3, 1, 1, 3]);
    expect result == 0;
}

method {:test} test_6()
{
    var result := smallest_change([1]);
    expect result == 0;
}

method {:test} test_7()
{
    var result := smallest_change([0, 1]);
    expect result == 1;
}