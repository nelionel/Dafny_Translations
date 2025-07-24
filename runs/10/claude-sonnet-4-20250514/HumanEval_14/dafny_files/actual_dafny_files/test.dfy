method all_prefixes(s: string) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := all_prefixes("");
    expect result == [];
}

method {:test} test_1()
{
    var result := all_prefixes("asdfgh");
    expect result == ["a", "as", "asd", "asdf", "asdfg", "asdfgh"];
}

method {:test} test_2()
{
    var result := all_prefixes("WWW");
    expect result == ["W", "WW", "WWW"];
}