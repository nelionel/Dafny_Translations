method decimal_to_binary(decimal: int) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := decimal_to_binary(0);
    expect result == "db0db";
}

method {:test} test_1()
{
    var result := decimal_to_binary(32);
    expect result == "db100000db";
}

method {:test} test_2()
{
    var result := decimal_to_binary(103);
    expect result == "db1100111db";
}

method {:test} test_3()
{
    var result := decimal_to_binary(15);
    expect result == "db1111db";
}