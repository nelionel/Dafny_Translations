method pluck(arr: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := pluck([4,2,3]);
    expect result == [2, 1];
}

method {:test} test_1()
{
    var result := pluck([1,2,3]);
    expect result == [2, 1];
}

method {:test} test_2()
{
    var result := pluck([]);
    expect result == [];
}

method {:test} test_3()
{
    var result := pluck([5, 0, 3, 0, 4, 2]);
    expect result == [0, 1];
}

method {:test} test_4()
{
    var result := pluck([1, 2, 3, 0, 5, 3]);
    expect result == [0, 3];
}

method {:test} test_5()
{
    var result := pluck([5, 4, 8, 4, 8]);
    expect result == [4, 1];
}

method {:test} test_6()
{
    var result := pluck([7, 6, 7, 1]);
    expect result == [6, 1];
}

method {:test} test_7()
{
    var result := pluck([7, 9, 7, 1]);
    expect result == [];
}