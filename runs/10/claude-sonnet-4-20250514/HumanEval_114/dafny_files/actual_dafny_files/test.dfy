method minSubArraySum(nums: seq<int>) returns (result: int)
    requires |nums| > 0
{
    result := 0;
}

method {:test} test_0()
{
    var result := minSubArraySum([2, 3, 4, 1, 2, 4]);
    expect result == 1;
}

method {:test} test_1()
{
    var result := minSubArraySum([-1, -2, -3]);
    expect result == -6;
}

method {:test} test_2()
{
    var result := minSubArraySum([-1, -2, -3, 2, -10]);
    expect result == -14;
}

method {:test} test_3()
{
    var result := minSubArraySum([-9999999999999999]);
    expect result == -9999999999999999;
}

method {:test} test_4()
{
    var result := minSubArraySum([0, 10, 20, 1000000]);
    expect result == 0;
}

method {:test} test_5()
{
    var result := minSubArraySum([-1, -2, -3, 10, -5]);
    expect result == -6;
}

method {:test} test_6()
{
    var result := minSubArraySum([100, -1, -2, -3, 10, -5]);
    expect result == -6;
}

method {:test} test_7()
{
    var result := minSubArraySum([10, 11, 13, 8, 3, 4]);
    expect result == 3;
}

method {:test} test_8()
{
    var result := minSubArraySum([100, -33, 32, -1, 0, -2]);
    expect result == -33;
}

method {:test} test_9()
{
    var result := minSubArraySum([-10]);
    expect result == -10;
}

method {:test} test_10()
{
    var result := minSubArraySum([7]);
    expect result == 7;
}

method {:test} test_11()
{
    var result := minSubArraySum([1, -1]);
    expect result == -1;
}