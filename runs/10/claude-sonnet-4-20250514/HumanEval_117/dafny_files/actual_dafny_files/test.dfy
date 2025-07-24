method select_words(s: string, n: nat) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := select_words("Mary had a little lamb", 4);
    expect result == ["little"];
}

method {:test} test_1()
{
    var result := select_words("Mary had a little lamb", 3);
    expect result == ["Mary", "lamb"];
}

method {:test} test_2()
{
    var result := select_words("simple white space", 2);
    expect result == [];
}

method {:test} test_3()
{
    var result := select_words("Hello world", 4);
    expect result == ["world"];
}

method {:test} test_4()
{
    var result := select_words("Uncle sam", 3);
    expect result == ["Uncle"];
}

method {:test} test_5()
{
    var result := select_words("", 4);
    expect result == [];
}

method {:test} test_6()
{
    var result := select_words("a b c d e f", 1);
    expect result == ["b", "c", "d", "f"];
}