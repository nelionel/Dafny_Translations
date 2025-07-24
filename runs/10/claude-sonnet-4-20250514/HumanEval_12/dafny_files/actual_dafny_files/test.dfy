method longest(strings: seq<string>) returns (result: string)
{
    return "";
}

method {:test} test_0()
{
    var result := longest([]);
    expect result == "";
}

method {:test} test_1()
{
    var result := longest(["x", "y", "z"]);
    expect result == "x";
}

method {:test} test_2()
{
    var result := longest(["x", "yyy", "zzzz", "www", "kkkk", "abc"]);
    expect result == "zzzz";
}