method intersperse(numbers: seq<int>, delimeter: int) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := intersperse([], 7);
    expect result == [];
}

method {:test} test_1()
{
    var result := intersperse([5, 6, 3, 2], 8);
    expect result == [5, 8, 6, 8, 3, 8, 2];
}

method {:test} test_2()
{
    var result := intersperse([2, 2, 2], 2);
    expect result == [2, 2, 2, 2, 2];
}