method exchange(lst1: seq<int>, lst2: seq<int>) returns (result: string)
{
    result := "NO";
}

method {:test} test_0()
{
    var result := exchange([1, 2, 3, 4], [1, 2, 3, 4]);
    expect result == "YES";
}

method {:test} test_1()
{
    var result := exchange([1, 2, 3, 4], [1, 5, 3, 4]);
    expect result == "NO";
}

method {:test} test_2()
{
    var result := exchange([1, 2, 3, 4], [2, 1, 4, 3]);
    expect result == "YES";
}

method {:test} test_3()
{
    var result := exchange([5, 7, 3], [2, 6, 4]);
    expect result == "YES";
}

method {:test} test_4()
{
    var result := exchange([5, 7, 3], [2, 6, 3]);
    expect result == "NO";
}

method {:test} test_5()
{
    var result := exchange([3, 2, 6, 1, 8, 9], [3, 5, 5, 1, 1, 1]);
    expect result == "NO";
}

method {:test} test_6()
{
    var result := exchange([100, 200], [200, 200]);
    expect result == "YES";
}