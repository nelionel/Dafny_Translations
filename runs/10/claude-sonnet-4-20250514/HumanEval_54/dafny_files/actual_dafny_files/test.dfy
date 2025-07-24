method same_chars(s0: string, s1: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := same_chars("eabcdzzzz", "dddzzzzzzzddeddabc");
    expect result == true;
}

method {:test} test_1()
{
    var result := same_chars("abcd", "dddddddabc");
    expect result == true;
}

method {:test} test_2()
{
    var result := same_chars("dddddddabc", "abcd");
    expect result == true;
}

method {:test} test_3()
{
    var result := same_chars("eabcd", "dddddddabc");
    expect result == false;
}

method {:test} test_4()
{
    var result := same_chars("abcd", "dddddddabcf");
    expect result == false;
}

method {:test} test_5()
{
    var result := same_chars("eabcdzzzz", "dddzzzzzzzddddabc");
    expect result == false;
}

method {:test} test_6()
{
    var result := same_chars("aabb", "aaccc");
    expect result == false;
}