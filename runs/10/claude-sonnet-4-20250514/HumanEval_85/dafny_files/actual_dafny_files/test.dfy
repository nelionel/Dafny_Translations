method add(lst: seq<int>) returns (result: int)
    requires |lst| > 0
{
    result := 0;
}

method {:test} test_0()
{
    var result := add([4, 88]);
    expect result == 88;
}

method {:test} test_1()
{
    var result := add([4, 5, 6, 7, 2, 122]);
    expect result == 122;
}

method {:test} test_2()
{
    var result := add([4, 0, 6, 7]);
    expect result == 0;
}

method {:test} test_3()
{
    var result := add([4, 4, 6, 8]);
    expect result == 12;
}