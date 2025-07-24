method prod_signs(arr: seq<int>) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := prod_signs([1, 2, 2, -4]);
    expect result == -9;
}

method {:test} test_1()
{
    var result := prod_signs([0, 1]);
    expect result == 0;
}

method {:test} test_2()
{
    var result := prod_signs([1, 1, 1, 2, 3, -1, 1]);
    expect result == -10;
}

method {:test} test_3()
{
    var result := prod_signs([]);
    expect result == 0;
}

method {:test} test_4()
{
    var result := prod_signs([2, 4, 1, 2, -1, -1, 9]);
    expect result == 20;
}

method {:test} test_5()
{
    var result := prod_signs([-1, 1, -1, 1]);
    expect result == 4;
}

method {:test} test_6()
{
    var result := prod_signs([-1, 1, 1, 1]);
    expect result == -4;
}

method {:test} test_7()
{
    var result := prod_signs([-1, 1, 1, 0]);
    expect result == 0;
}