method add(x: int, y: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := add(0, 1);
    expect result == 1;
}

method {:test} test_1()
{
    var result := add(1, 0);
    expect result == 1;
}

method {:test} test_2()
{
    var result := add(2, 3);
    expect result == 5;
}

method {:test} test_3()
{
    var result := add(5, 7);
    expect result == 12;
}

method {:test} test_4()
{
    var result := add(7, 5);
    expect result == 12;
}