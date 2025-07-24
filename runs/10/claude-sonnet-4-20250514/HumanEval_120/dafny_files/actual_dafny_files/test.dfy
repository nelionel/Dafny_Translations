method maximum(arr: seq<int>, k: int) returns (result: seq<int>)
{
    return [];
}

method {:test} test_0()
{
    var result := maximum([-3, -4, 5], 3);
    expect result == [-4, -3, 5];
}

method {:test} test_1()
{
    var result := maximum([4, -4, 4], 2);
    expect result == [4, 4];
}

method {:test} test_2()
{
    var result := maximum([-3, 2, 1, 2, -1, -2, 1], 1);
    expect result == [2];
}

method {:test} test_3()
{
    var result := maximum([123, -123, 20, 0, 1, 2, -3], 3);
    expect result == [2, 20, 123];
}

method {:test} test_4()
{
    var result := maximum([-123, 20, 0, 1, 2, -3], 4);
    expect result == [0, 1, 2, 20];
}

method {:test} test_5()
{
    var result := maximum([5, 15, 0, 3, -13, -8, 0], 7);
    expect result == [-13, -8, 0, 0, 3, 5, 15];
}

method {:test} test_6()
{
    var result := maximum([-1, 0, 2, 5, 3, -10], 2);
    expect result == [3, 5];
}

method {:test} test_7()
{
    var result := maximum([1, 0, 5, -7], 1);
    expect result == [5];
}

method {:test} test_8()
{
    var result := maximum([4, -4], 2);
    expect result == [-4, 4];
}

method {:test} test_9()
{
    var result := maximum([-10, 10], 2);
    expect result == [-10, 10];
}

method {:test} test_10()
{
    var result := maximum([1, 2, 3, -23, 243, -400, 0], 0);
    expect result == [];
}