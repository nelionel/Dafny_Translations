method solution(lst: seq<int>) returns (result: int)
    requires |lst| > 0
{
    result := 0;
}

method {:test} test_0()
{
    var result := solution([5, 8, 7, 1]);
    expect result == 12;
}

method {:test} test_1()
{
    var result := solution([3, 3, 3, 3, 3]);
    expect result == 9;
}

method {:test} test_2()
{
    var result := solution([30, 13, 24, 321]);
    expect result == 0;
}

method {:test} test_3()
{
    var result := solution([5, 9]);
    expect result == 5;
}

method {:test} test_4()
{
    var result := solution([2, 4, 8]);
    expect result == 0;
}

method {:test} test_5()
{
    var result := solution([30, 13, 23, 32]);
    expect result == 23;
}

method {:test} test_6()
{
    var result := solution([3, 13, 2, 9]);
    expect result == 3;
}