method string_xor(a: string, b: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := string_xor("111000", "101010");
    expect result == "010010";
}

method {:test} test_1()
{
    var result := string_xor("1", "1");
    expect result == "0";
}

method {:test} test_2()
{
    var result := string_xor("0101", "0000");
    expect result == "0101";
}