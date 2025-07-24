method concatenate(strings: seq<string>) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := concatenate([]);
    expect result == "";
}

method {:test} test_1()
{
    var result := concatenate(["x", "y", "z"]);
    expect result == "xyz";
}

method {:test} test_2()
{
    var result := concatenate(["x", "y", "z", "w", "k"]);
    expect result == "xyzwk";
}