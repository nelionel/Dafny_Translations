method words_string(s: string) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := words_string("Hi, my name is John");
    expect result == ["Hi", "my", "name", "is", "John"];
}

method {:test} test_1()
{
    var result := words_string("One, two, three, four, five, six");
    expect result == ["One", "two", "three", "four", "five", "six"];
}

method {:test} test_2()
{
    var result := words_string("Hi, my name");
    expect result == ["Hi", "my", "name"];
}

method {:test} test_3()
{
    var result := words_string("One,, two, three, four, five, six,");
    expect result == ["One", "two", "three", "four", "five", "six"];
}

method {:test} test_4()
{
    var result := words_string("");
    expect result == [];
}

method {:test} test_5()
{
    var result := words_string("ahmed     , gamal");
    expect result == ["ahmed", "gamal"];
}