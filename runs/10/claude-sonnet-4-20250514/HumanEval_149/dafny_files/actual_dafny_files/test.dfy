method sorted_list_sum(lst: seq<string>) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := sorted_list_sum(["aa", "a", "aaa"]);
    expect result == ["aa"];
}

method {:test} test_1()
{
    var result := sorted_list_sum(["school", "AI", "asdf", "b"]);
    expect result == ["AI", "asdf", "school"];
}

method {:test} test_2()
{
    var result := sorted_list_sum(["d", "b", "c", "a"]);
    expect result == [];
}

method {:test} test_3()
{
    var result := sorted_list_sum(["d", "dcba", "abcd", "a"]);
    expect result == ["abcd", "dcba"];
}

method {:test} test_4()
{
    var result := sorted_list_sum(["AI", "ai", "au"]);
    expect result == ["AI", "ai", "au"];
}

method {:test} test_5()
{
    var result := sorted_list_sum(["a", "b", "b", "c", "c", "a"]);
    expect result == [];
}

method {:test} test_6()
{
    var result := sorted_list_sum(["aaaa", "bbbb", "dd", "cc"]);
    expect result == ["cc", "dd", "aaaa", "bbbb"];
}