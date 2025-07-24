method common(l1: seq<int>, l2: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := common([1, 4, 3, 34, 653, 2, 5], [5, 7, 1, 5, 9, 653, 121]);
    expect result == [1, 5, 653];
}

method {:test} test_1()
{
    var result := common([5, 3, 2, 8], [3, 2]);
    expect result == [2, 3];
}

method {:test} test_2()
{
    var result := common([4, 3, 2, 8], [3, 2, 4]);
    expect result == [2, 3, 4];
}

method {:test} test_3()
{
    var result := common([4, 3, 2, 8], []);
    expect result == [];
}