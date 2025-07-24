method by_length(arr: seq<int>) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := by_length([2, 1, 1, 4, 5, 8, 2, 3]);
    expect result == ["Eight", "Five", "Four", "Three", "Two", "Two", "One", "One"];
}

method {:test} test_1()
{
    var result := by_length([]);
    expect result == [];
}

method {:test} test_2()
{
    var result := by_length([1, -1, 55]);
    expect result == ["One"];
}

method {:test} test_3()
{
    var result := by_length([1, -1, 3, 2]);
    expect result == ["Three", "Two", "One"];
}

method {:test} test_4()
{
    var result := by_length([9, 4, 8]);
    expect result == ["Nine", "Eight", "Four"];
}