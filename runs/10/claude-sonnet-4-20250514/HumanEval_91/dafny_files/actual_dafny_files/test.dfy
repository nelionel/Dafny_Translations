method is_bored(S: string) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := is_bored("Hello world");
    expect result == 0;
}

method {:test} test_1()
{
    var result := is_bored("Is the sky blue?");
    expect result == 0;
}

method {:test} test_2()
{
    var result := is_bored("I love It !");
    expect result == 1;
}

method {:test} test_3()
{
    var result := is_bored("bIt");
    expect result == 0;
}

method {:test} test_4()
{
    var result := is_bored("I feel good today. I will be productive. will kill It");
    expect result == 2;
}

method {:test} test_5()
{
    var result := is_bored("You and I are going for a walk");
    expect result == 0;
}

method {:test} test_6()
{
    // This corresponds to "assert True" which always passes
    expect true;
}