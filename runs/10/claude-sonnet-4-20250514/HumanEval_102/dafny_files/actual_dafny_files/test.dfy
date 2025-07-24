method choose_num(x: int, y: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := choose_num(12, 15);
    expect result == 14;
}

method {:test} test_1()
{
    var result := choose_num(13, 12);
    expect result == -1;
}

method {:test} test_2()
{
    var result := choose_num(33, 12354);
    expect result == 12354;
}

method {:test} test_3()
{
    var result := choose_num(5234, 5233);
    expect result == -1;
}

method {:test} test_4()
{
    var result := choose_num(6, 29);
    expect result == 28;
}

method {:test} test_5()
{
    var result := choose_num(27, 10);
    expect result == -1;
}

method {:test} test_6()
{
    var result := choose_num(7, 7);
    expect result == -1;
}

method {:test} test_7()
{
    var result := choose_num(546, 546);
    expect result == 546;
}