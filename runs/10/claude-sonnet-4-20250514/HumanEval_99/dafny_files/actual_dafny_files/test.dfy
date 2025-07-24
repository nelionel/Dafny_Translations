method closest_integer(value: string) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := closest_integer("10");
    expect result == 10;
}

method {:test} test_1()
{
    var result := closest_integer("14.5");
    expect result == 15;
}

method {:test} test_2()
{
    var result := closest_integer("-15.5");
    expect result == -16;
}

method {:test} test_3()
{
    var result := closest_integer("15.3");
    expect result == 15;
}

method {:test} test_4()
{
    var result := closest_integer("0");
    expect result == 0;
}