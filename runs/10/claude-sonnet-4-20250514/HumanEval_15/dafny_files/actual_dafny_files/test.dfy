method string_sequence(n: int) returns (result: string)
    requires n >= 0
    ensures |result| > 0
{
    result := "";
}

method {:test} test_0()
{
    var result := string_sequence(0);
    expect result == "0";
}

method {:test} test_1()
{
    var result := string_sequence(3);
    expect result == "0 1 2 3";
}

method {:test} test_2()
{
    var result := string_sequence(10);
    expect result == "0 1 2 3 4 5 6 7 8 9 10";
}