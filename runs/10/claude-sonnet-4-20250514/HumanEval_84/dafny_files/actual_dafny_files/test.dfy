method solve(N: int) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := solve(1000);
    expect result == "1";
}

method {:test} test_1()
{
    var result := solve(150);
    expect result == "110";
}

method {:test} test_2()
{
    var result := solve(147);
    expect result == "1100";
}

method {:test} test_3()
{
    var result := solve(333);
    expect result == "1001";
}

method {:test} test_4()
{
    var result := solve(963);
    expect result == "10010";
}