method strlen(s: string) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := strlen("");
    expect result == 0;
}

method {:test} test_1()
{
    var result := strlen("x");
    expect result == 1;
}

method {:test} test_2()
{
    var result := strlen("asdasnakj");
    expect result == 9;
}