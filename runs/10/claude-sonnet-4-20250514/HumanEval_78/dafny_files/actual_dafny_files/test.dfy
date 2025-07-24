method hex_key(num: string) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := hex_key("AB");
    expect result == 1;
}

method {:test} test_1()
{
    var result := hex_key("1077E");
    expect result == 2;
}

method {:test} test_2()
{
    var result := hex_key("ABED1A33");
    expect result == 4;
}

method {:test} test_3()
{
    var result := hex_key("2020");
    expect result == 2;
}

method {:test} test_4()
{
    var result := hex_key("123456789ABCDEF0");
    expect result == 6;
}

method {:test} test_5()
{
    var result := hex_key("112233445566778899AABBCCDDEEFF00");
    expect result == 12;
}

method {:test} test_6()
{
    var result := hex_key("");
    expect result == 0;
}