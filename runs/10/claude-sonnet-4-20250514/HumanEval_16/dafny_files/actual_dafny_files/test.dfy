method count_distinct_characters(s: string) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := count_distinct_characters("");
    expect result == 0;
}

method {:test} test_1()
{
    var result := count_distinct_characters("abcde");
    expect result == 5;
}

method {:test} test_2()
{
    var result := count_distinct_characters("abcdecadeCADE");
    expect result == 5;
}

method {:test} test_3()
{
    var result := count_distinct_characters("aaaaAAAAaaaa");
    expect result == 1;
}

method {:test} test_4()
{
    var result := count_distinct_characters("Jerry jERRY JeRRRY");
    expect result == 5;
}