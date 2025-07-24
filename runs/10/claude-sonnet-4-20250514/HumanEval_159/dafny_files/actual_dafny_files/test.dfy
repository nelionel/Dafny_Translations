method eat(number: int, need: int, remaining: int) returns (result: seq<int>)
{
    result := [0, 0];
}

method {:test} test_0()
{
    var result := eat(5, 6, 10);
    expect result == [11, 4];
}

method {:test} test_1()
{
    var result := eat(4, 8, 9);
    expect result == [12, 1];
}

method {:test} test_2()
{
    var result := eat(1, 10, 10);
    expect result == [11, 0];
}

method {:test} test_3()
{
    var result := eat(2, 11, 5);
    expect result == [7, 0];
}

method {:test} test_4()
{
    var result := eat(4, 5, 7);
    expect result == [9, 2];
}

method {:test} test_5()
{
    var result := eat(4, 5, 1);
    expect result == [5, 0];
}