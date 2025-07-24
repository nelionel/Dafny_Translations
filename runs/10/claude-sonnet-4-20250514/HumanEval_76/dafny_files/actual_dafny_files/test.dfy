method is_simple_power(x: int, n: int) returns (result: bool)
{
    result := false;
}

function abs(x: int): int
{
    if x >= 0 then x else -x
}

method {:test} test_0()
{
    var result := is_simple_power(16, 2);
    expect result == true;
}

method {:test} test_1()
{
    var result := is_simple_power(143214, 16);
    expect result == false;
}

method {:test} test_2()
{
    var result := is_simple_power(4, 2);
    expect result == true;
}

method {:test} test_3()
{
    var result := is_simple_power(9, 3);
    expect result == true;
}

method {:test} test_4()
{
    var result := is_simple_power(16, 4);
    expect result == true;
}

method {:test} test_5()
{
    var result := is_simple_power(24, 2);
    expect result == false;
}

method {:test} test_6()
{
    var result := is_simple_power(128, 4);
    expect result == false;
}

method {:test} test_7()
{
    var result := is_simple_power(12, 6);
    expect result == false;
}

method {:test} test_8()
{
    var result := is_simple_power(1, 1);
    expect result == true;
}

method {:test} test_9()
{
    var result := is_simple_power(1, 12);
    expect result == true;
}