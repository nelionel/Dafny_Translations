method below_threshold(l: seq<int>, t: int) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := below_threshold([1, 2, 4, 10], 100);
    expect result == true;
}

method {:test} test_1()
{
    var result := below_threshold([1, 20, 4, 10], 5);
    expect result == false;
}

method {:test} test_2()
{
    var result := below_threshold([1, 20, 4, 10], 21);
    expect result == true;
}

method {:test} test_3()
{
    var result := below_threshold([1, 20, 4, 10], 22);
    expect result == true;
}

method {:test} test_4()
{
    var result := below_threshold([1, 8, 4, 10], 11);
    expect result == true;
}

method {:test} test_5()
{
    var result := below_threshold([1, 8, 4, 10], 10);
    expect result == false;
}