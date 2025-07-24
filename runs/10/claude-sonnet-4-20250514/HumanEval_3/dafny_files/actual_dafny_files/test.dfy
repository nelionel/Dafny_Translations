method below_zero(operations: seq<int>) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := below_zero([]);
    expect result == false;
}

method {:test} test_1()
{
    var result := below_zero([1, 2, -3, 1, 2, -3]);
    expect result == false;
}

method {:test} test_2()
{
    var result := below_zero([1, 2, -4, 5, 6]);
    expect result == true;
}

method {:test} test_3()
{
    var result := below_zero([1, -1, 2, -2, 5, -5, 4, -4]);
    expect result == false;
}

method {:test} test_4()
{
    var result := below_zero([1, -1, 2, -2, 5, -5, 4, -5]);
    expect result == true;
}

method {:test} test_5()
{
    var result := below_zero([1, -2, 2, -2, 5, -5, 4, -4]);
    expect result == true;
}