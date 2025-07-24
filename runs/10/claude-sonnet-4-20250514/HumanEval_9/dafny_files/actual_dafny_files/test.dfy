method rolling_max(numbers: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := rolling_max([]);
    expect result == [];
}

method {:test} test_1()
{
    var result := rolling_max([1, 2, 3, 4]);
    expect result == [1, 2, 3, 4];
}

method {:test} test_2()
{
    var result := rolling_max([4, 3, 2, 1]);
    expect result == [4, 4, 4, 4];
}

method {:test} test_3()
{
    var result := rolling_max([3, 2, 3, 100, 3]);
    expect result == [3, 3, 3, 100, 100];
}