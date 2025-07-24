method unique(l: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := unique([5, 3, 5, 2, 3, 3, 9, 0, 123]);
    expect result == [0, 2, 3, 5, 9, 123];
}