method filter_by_prefix(strings: seq<string>, prefix: string) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := filter_by_prefix([], "john");
    expect result == [];
}

method {:test} test_1()
{
    var result := filter_by_prefix(["xxx", "asd", "xxy", "john doe", "xxxAAA", "xxx"], "xxx");
    expect result == ["xxx", "xxxAAA", "xxx"];
}