method will_it_fly(q: seq<int>, w: int) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := will_it_fly([3, 2, 3], 9);
    expect result == true;
}

method {:test} test_1()
{
    var result := will_it_fly([1, 2], 5);
    expect result == false;
}

method {:test} test_2()
{
    var result := will_it_fly([3], 5);
    expect result == true;
}

method {:test} test_3()
{
    var result := will_it_fly([3, 2, 3], 1);
    expect result == false;
}

method {:test} test_4()
{
    var result := will_it_fly([1, 2, 3], 6);
    expect result == false;
}

method {:test} test_5()
{
    var result := will_it_fly([5], 5);
    expect result == true;
}