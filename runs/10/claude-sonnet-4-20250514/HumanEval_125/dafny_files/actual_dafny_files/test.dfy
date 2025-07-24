method split_words(txt: string) returns (result: seq<string>)
{
    result := [""];
}

method {:test} test_0()
{
    var result := split_words("Hello world!");
    expect result == ["Hello","world!"];
}

method {:test} test_1()
{
    var result := split_words("Hello,world!");
    expect result == ["Hello","world!"];
}

method {:test} test_2()
{
    var result := split_words("Hello world,!");
    expect result == ["Hello","world,!"];
}

method {:test} test_3()
{
    var result := split_words("Hello,Hello,world !");
    expect result == ["Hello,Hello,world","!"];
}

method {:test} test_4()
{
    var result := split_words("abcdef");
    expect result == ["3"];
}

method {:test} test_5()
{
    var result := split_words("aaabb");
    expect result == ["2"];
}

method {:test} test_6()
{
    var result := split_words("aaaBb");
    expect result == ["1"];
}

method {:test} test_7()
{
    var result := split_words("");
    expect result == ["0"];
}