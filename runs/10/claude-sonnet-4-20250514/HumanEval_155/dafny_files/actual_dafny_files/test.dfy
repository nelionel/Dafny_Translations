method even_odd_count(num: int) returns (result: seq<int>)
{
    result := [0, 0];
}

method {:test} test_0()
{
    var result := even_odd_count(7);
    expect result[0] == 0 && result[1] == 1;
}

method {:test} test_1()
{
    var result := even_odd_count(-78);
    expect result[0] == 1 && result[1] == 1;
}

method {:test} test_2()
{
    var result := even_odd_count(3452);
    expect result[0] == 2 && result[1] == 2;
}

method {:test} test_3()
{
    var result := even_odd_count(346211);
    expect result[0] == 3 && result[1] == 3;
}

method {:test} test_4()
{
    var result := even_odd_count(-345821);
    expect result[0] == 3 && result[1] == 3;
}

method {:test} test_5()
{
    var result := even_odd_count(-2);
    expect result[0] == 1 && result[1] == 0;
}

method {:test} test_6()
{
    var result := even_odd_count(-45347);
    expect result[0] == 2 && result[1] == 3;
}

method {:test} test_7()
{
    var result := even_odd_count(0);
    expect result[0] == 1 && result[1] == 0;
}