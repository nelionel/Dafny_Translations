method can_arrange(arr: seq<int>) returns (result: int)
{
    return 0;
}

method {:test} test_0()
{
    var result := can_arrange([1,2,4,3,5]);
    expect result == 3;
}

method {:test} test_1()
{
    var result := can_arrange([1,2,4,5]);
    expect result == -1;
}

method {:test} test_2()
{
    var result := can_arrange([1,4,2,5,6,7,8,9,10]);
    expect result == 2;
}

method {:test} test_3()
{
    var result := can_arrange([4,8,5,7,3]);
    expect result == 4;
}

method {:test} test_4()
{
    var result := can_arrange([]);
    expect result == -1;
}