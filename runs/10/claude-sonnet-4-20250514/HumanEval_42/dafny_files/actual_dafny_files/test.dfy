method incr_list(l: seq<int>) returns (result: seq<int>)
{
    return [];
}

method {:test} test_0()
{
    var result := incr_list([]);
    expect result == [];
}

method {:test} test_1()
{
    var result := incr_list([3, 2, 1]);
    expect result == [4, 3, 2];
}

method {:test} test_2()
{
    var result := incr_list([5, 2, 5, 2, 3, 3, 9, 0, 123]);
    expect result == [6, 3, 6, 3, 4, 4, 10, 1, 124];
}