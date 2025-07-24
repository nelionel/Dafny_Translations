method specialFilter(nums: seq<int>) returns (result: int)
{
    result := 0;
}

function isOdd(digit: int): bool
{
    false
}

function getFirstDigit(num: int): int
    requires num > 0
{
    1
}

method {:test} test_0()
{
    var result := specialFilter([5, -2, 1, -5]);
    expect result == 0;
}

method {:test} test_1()
{
    var result := specialFilter([15, -73, 14, -15]);
    expect result == 1;
}

method {:test} test_2()
{
    var result := specialFilter([33, -2, -3, 45, 21, 109]);
    expect result == 2;
}

method {:test} test_3()
{
    var result := specialFilter([43, -12, 93, 125, 121, 109]);
    expect result == 4;
}

method {:test} test_4()
{
    var result := specialFilter([71, -2, -33, 75, 21, 19]);
    expect result == 3;
}

method {:test} test_5()
{
    var result := specialFilter([1]);
    expect result == 0;
}

method {:test} test_6()
{
    var result := specialFilter([]);
    expect result == 0;
}