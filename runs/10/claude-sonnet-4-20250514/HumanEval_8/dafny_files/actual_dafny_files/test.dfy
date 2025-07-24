method sum_product(numbers: seq<int>) returns (result: seq<int>)
{
    result := [0, 0];
}

method {:test} test_0()
{
    var result := sum_product([]);
    expect result == [0, 1];
}

method {:test} test_1()
{
    var result := sum_product([1, 1, 1]);
    expect result == [3, 1];
}

method {:test} test_2()
{
    var result := sum_product([100, 0]);
    expect result == [100, 0];
}

method {:test} test_3()
{
    var result := sum_product([3, 5, 7]);
    expect result == [15, 105];
}

method {:test} test_4()
{
    var result := sum_product([10]);
    expect result == [10, 10];
}