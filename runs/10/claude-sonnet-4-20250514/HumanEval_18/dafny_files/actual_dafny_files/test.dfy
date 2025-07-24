method how_many_times(str: string, substring: string) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := how_many_times("", "x");
    expect result == 0;
}

method {:test} test_1()
{
    var result := how_many_times("xyxyxyx", "x");
    expect result == 4;
}

method {:test} test_2()
{
    var result := how_many_times("cacacacac", "cac");
    expect result == 4;
}

method {:test} test_3()
{
    var result := how_many_times("john doe", "john");
    expect result == 1;
}