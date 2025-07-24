method get_positive(l: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := get_positive([-1, -2, 4, 5, 6]);
    expect result == [4, 5, 6];
}

method {:test} test_1()
{
    var result := get_positive([5, 3, -5, 2, 3, 3, 9, 0, 123, 1, -10]);
    expect result == [5, 3, 2, 3, 3, 9, 123, 1];
}

method {:test} test_2()
{
    var result := get_positive([-1, -2]);
    expect result == [];
}

method {:test} test_3()
{
    var result := get_positive([]);
    expect result == [];
}