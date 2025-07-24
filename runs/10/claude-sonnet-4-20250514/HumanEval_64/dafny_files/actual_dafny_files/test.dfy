method vowels_count(s: string) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := vowels_count("abcde");
    expect result == 2;
}

method {:test} test_1()
{
    var result := vowels_count("Alone");
    expect result == 3;
}

method {:test} test_2()
{
    var result := vowels_count("key");
    expect result == 2;
}

method {:test} test_3()
{
    var result := vowels_count("bye");
    expect result == 1;
}

method {:test} test_4()
{
    var result := vowels_count("keY");
    expect result == 2;
}

method {:test} test_5()
{
    var result := vowels_count("bYe");
    expect result == 1;
}

method {:test} test_6()
{
    var result := vowels_count("ACEDY");
    expect result == 3;
}