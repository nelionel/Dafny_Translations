method monotonic(l: seq<int>) returns (result: bool)
{
    return false;
}

method {:test} test_0()
{
    var result := monotonic([1, 2, 4, 10]);
    expect result == true;
}

method {:test} test_1()
{
    var result := monotonic([1, 2, 4, 20]);
    expect result == true;
}

method {:test} test_2()
{
    var result := monotonic([1, 20, 4, 10]);
    expect result == false;
}

method {:test} test_3()
{
    var result := monotonic([4, 1, 0, -10]);
    expect result == true;
}

method {:test} test_4()
{
    var result := monotonic([4, 1, 1, 0]);
    expect result == true;
}

method {:test} test_5()
{
    var result := monotonic([1, 2, 3, 2, 5, 60]);
    expect result == false;
}

method {:test} test_6()
{
    var result := monotonic([1, 2, 3, 4, 5, 60]);
    expect result == true;
}

method {:test} test_7()
{
    var result := monotonic([9, 9, 9, 9]);
    expect result == true;
}