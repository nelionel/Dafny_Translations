method f(n: int) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := f(5);
    expect result == [1, 2, 6, 24, 15];
}

method {:test} test_1()
{
    var result := f(7);
    expect result == [1, 2, 6, 24, 15, 720, 28];
}

method {:test} test_2()
{
    var result := f(1);
    expect result == [1];
}

method {:test} test_3()
{
    var result := f(3);
    expect result == [1, 2, 6];
}