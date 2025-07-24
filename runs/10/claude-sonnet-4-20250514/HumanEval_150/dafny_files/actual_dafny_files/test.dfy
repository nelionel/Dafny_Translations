method x_or_y(n: int, x: int, y: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := x_or_y(7, 34, 12);
    expect result == 34;
}

method {:test} test_1()
{
    var result := x_or_y(15, 8, 5);
    expect result == 5;
}

method {:test} test_2()
{
    var result := x_or_y(3, 33, 5212);
    expect result == 33;
}

method {:test} test_3()
{
    var result := x_or_y(1259, 3, 52);
    expect result == 3;
}

method {:test} test_4()
{
    var result := x_or_y(7919, -1, 12);
    expect result == -1;
}

method {:test} test_5()
{
    var result := x_or_y(3609, 1245, 583);
    expect result == 583;
}

method {:test} test_6()
{
    var result := x_or_y(91, 56, 129);
    expect result == 129;
}

method {:test} test_7()
{
    var result := x_or_y(6, 34, 1234);
    expect result == 1234;
}

method {:test} test_8()
{
    var result := x_or_y(1, 2, 0);
    expect result == 0;
}

method {:test} test_9()
{
    var result := x_or_y(2, 2, 0);
    expect result == 2;
}