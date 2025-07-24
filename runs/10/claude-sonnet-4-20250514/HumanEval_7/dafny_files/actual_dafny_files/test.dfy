method filter_by_substring(strings: seq<string>, substring: string) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := filter_by_substring([], "john");
    expect result == [];
}

method {:test} test_1()
{
    var result := filter_by_substring(["xxx", "asd", "xxy", "john doe", "xxxAAA", "xxx"], "xxx");
    expect result == ["xxx", "xxxAAA", "xxx"];
}

method {:test} test_2()
{
    var result := filter_by_substring(["xxx", "asd", "aaaxxy", "john doe", "xxxAAA", "xxx"], "xx");
    expect result == ["xxx", "aaaxxy", "xxxAAA", "xxx"];
}

method {:test} test_3()
{
    var result := filter_by_substring(["grunt", "trumpet", "prune", "gruesome"], "run");
    expect result == ["grunt", "prune"];
}