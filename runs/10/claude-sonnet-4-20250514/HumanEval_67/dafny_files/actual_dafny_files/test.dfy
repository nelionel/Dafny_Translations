method fruit_distribution(s: string, n: int) returns (mangoes: int)
    requires n >= 0
    ensures mangoes >= 0
{
    mangoes := 0;
}

method {:test} test_0()
{
    var result := fruit_distribution("5 apples and 6 oranges", 19);
    expect result == 8;
}

method {:test} test_1()
{
    var result := fruit_distribution("5 apples and 6 oranges", 21);
    expect result == 10;
}

method {:test} test_2()
{
    var result := fruit_distribution("0 apples and 1 oranges", 3);
    expect result == 2;
}

method {:test} test_3()
{
    var result := fruit_distribution("1 apples and 0 oranges", 3);
    expect result == 2;
}

method {:test} test_4()
{
    var result := fruit_distribution("2 apples and 3 oranges", 100);
    expect result == 95;
}

method {:test} test_5()
{
    var result := fruit_distribution("2 apples and 3 oranges", 5);
    expect result == 0;
}

method {:test} test_6()
{
    var result := fruit_distribution("1 apples and 100 oranges", 120);
    expect result == 19;
}