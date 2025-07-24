method sum_squares(lst: seq<real>) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := sum_squares([1.0, 2.0, 3.0]);
    expect result == 14;
}

method {:test} test_1()
{
    var result := sum_squares([1.0, 2.0, 3.0]);
    expect result == 14;
}

method {:test} test_2()
{
    var result := sum_squares([1.0, 3.0, 5.0, 7.0]);
    expect result == 84;
}

method {:test} test_3()
{
    var result := sum_squares([1.4, 4.2, 0.0]);
    expect result == 29;
}

method {:test} test_4()
{
    var result := sum_squares([-2.4, 1.0, 1.0]);
    expect result == 6;
}

method {:test} test_5()
{
    var result := sum_squares([100.0, 1.0, 15.0, 2.0]);
    expect result == 10230;
}

method {:test} test_6()
{
    var result := sum_squares([10000.0, 10000.0]);
    expect result == 200000000;
}

method {:test} test_7()
{
    var result := sum_squares([-1.4, 4.6, 6.3]);
    expect result == 75;
}

method {:test} test_8()
{
    var result := sum_squares([-1.4, 17.9, 18.9, 19.9]);
    expect result == 1086;
}

method {:test} test_9()
{
    var result := sum_squares([0.0]);
    expect result == 0;
}

method {:test} test_10()
{
    var result := sum_squares([-1.0]);
    expect result == 1;
}

method {:test} test_11()
{
    var result := sum_squares([-1.0, 1.0, 0.0]);
    expect result == 2;
}