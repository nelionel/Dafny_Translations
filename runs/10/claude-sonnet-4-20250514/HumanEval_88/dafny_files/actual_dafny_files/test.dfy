method sort_array(arr: seq<nat>) returns (result: seq<nat>)
{
    result := [];
}

method {:test} test_0()
{
    var result := sort_array([]);
    expect result == [];
}

method {:test} test_1()
{
    var result := sort_array([5]);
    expect result == [5];
}

method {:test} test_2()
{
    var result := sort_array([2, 4, 3, 0, 1, 5]);
    expect result == [0, 1, 2, 3, 4, 5];
}

method {:test} test_3()
{
    var result := sort_array([2, 4, 3, 0, 1, 5, 6]);
    expect result == [6, 5, 4, 3, 2, 1, 0];
}

method {:test} test_4()
{
    var result := sort_array([2, 1]);
    expect result == [1, 2];
}

method {:test} test_5()
{
    var result := sort_array([15, 42, 87, 32, 11, 0]);
    expect result == [0, 11, 15, 32, 42, 87];
}

method {:test} test_6()
{
    var result := sort_array([21, 14, 23, 11]);
    expect result == [23, 21, 14, 11];
}