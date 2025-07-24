method sum_to_n(n: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := sum_to_n(1);
    expect result == 1;
}

method {:test} test_1()
{
    var result := sum_to_n(6);
    expect result == 21;
}

method {:test} test_2()
{
    var result := sum_to_n(11);
    expect result == 66;
}

method {:test} test_3()
{
    var result := sum_to_n(30);
    expect result == 465;
}

method {:test} test_4()
{
    var result := sum_to_n(100);
    expect result == 5050;
}