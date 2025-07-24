method sum_squares(lst: seq<int>) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := sum_squares([1,2,3]);
    expect result == 6;
}

method {:test} test_1()
{
    var result := sum_squares([1,4,9]);
    expect result == 14;
}

method {:test} test_2()
{
    var result := sum_squares([]);
    expect result == 0;
}

method {:test} test_3()
{
    var result := sum_squares([1,1,1,1,1,1,1,1,1]);
    expect result == 9;
}

method {:test} test_4()
{
    var result := sum_squares([-1,-1,-1,-1,-1,-1,-1,-1,-1]);
    expect result == -3;
}

method {:test} test_5()
{
    var result := sum_squares([0]);
    expect result == 0;
}

method {:test} test_6()
{
    var result := sum_squares([-1,-5,2,-1,-5]);
    expect result == -126;
}

method {:test} test_7()
{
    var result := sum_squares([-56,-99,1,0,-2]);
    expect result == 3030;
}

method {:test} test_8()
{
    var result := sum_squares([-1,0,0,0,0,0,0,0,-1]);
    expect result == 0;
}

method {:test} test_9()
{
    var result := sum_squares([-16, -9, -2, 36, 36, 26, -20, 25, -40, 20, -4, 12, -26, 35, 37]);
    expect result == -14196;
}

method {:test} test_10()
{
    var result := sum_squares([-1, -3, 17, -1, -15, 13, -1, 14, -14, -12, -5, 14, -14, 6, 13, 11, 16, 16, 4, 10]);
    expect result == -1448;
}