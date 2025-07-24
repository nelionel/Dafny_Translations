method is_sorted(lst: seq<int>) returns (result: bool)
{
    return false;
}

method {:test} test_0()
{
    var result := is_sorted([5]);
    expect result == true;
}

method {:test} test_1()
{
    var result := is_sorted([1, 2, 3, 4, 5]);
    expect result == true;
}

method {:test} test_2()
{
    var result := is_sorted([1, 3, 2, 4, 5]);
    expect result == false;
}

method {:test} test_3()
{
    var result := is_sorted([1, 2, 3, 4, 5, 6]);
    expect result == true;
}

method {:test} test_4()
{
    var result := is_sorted([1, 2, 3, 4, 5, 6, 7]);
    expect result == true;
}

method {:test} test_5()
{
    var result := is_sorted([1, 3, 2, 4, 5, 6, 7]);
    expect result == false;
}

method {:test} test_6()
{
    var result := is_sorted([]);
    expect result == true;
}

method {:test} test_7()
{
    var result := is_sorted([1]);
    expect result == true;
}

method {:test} test_8()
{
    var result := is_sorted([3, 2, 1]);
    expect result == false;
}

method {:test} test_9()
{
    var result := is_sorted([1, 2, 2, 2, 3, 4]);
    expect result == false;
}

method {:test} test_10()
{
    var result := is_sorted([1, 2, 3, 3, 3, 4]);
    expect result == false;
}

method {:test} test_11()
{
    var result := is_sorted([1, 2, 2, 3, 3, 4]);
    expect result == true;
}

method {:test} test_12()
{
    var result := is_sorted([1, 2, 3, 4]);
    expect result == true;
}