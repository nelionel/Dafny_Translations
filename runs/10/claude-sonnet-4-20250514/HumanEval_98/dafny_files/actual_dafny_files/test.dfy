method count_upper(s: string) returns (count: int)
{
    count := 0;
}

predicate is_uppercase_vowel(c: char)
{
    false
}

method {:test} test_0()
{
    var result := count_upper("aBCdEf");
    expect result == 1;
}

method {:test} test_1()
{
    var result := count_upper("abcdefg");
    expect result == 0;
}

method {:test} test_2()
{
    var result := count_upper("dBBE");
    expect result == 0;
}

method {:test} test_3()
{
    var result := count_upper("B");
    expect result == 0;
}

method {:test} test_4()
{
    var result := count_upper("U");
    expect result == 1;
}

method {:test} test_5()
{
    var result := count_upper("");
    expect result == 0;
}

method {:test} test_6()
{
    var result := count_upper("EEEE");
    expect result == 2;
}