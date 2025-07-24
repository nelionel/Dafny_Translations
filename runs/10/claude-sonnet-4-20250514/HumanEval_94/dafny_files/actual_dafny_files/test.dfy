method skjkasdkd(lst: seq<int>) returns (result: int)
    ensures result >= 0
{
    result := 0;
}

function is_prime(n: int): bool
{
    false
}

function has_no_odd_divisors(n: int, candidate: int): bool
    requires n >= 3
    requires candidate >= 3 && candidate % 2 == 1
{
    false
}

function sum_of_digits(n: int): int
    requires n >= 0
{
    0
}

method {:test} test_0()
{
    var result := skjkasdkd([0,3,2,1,3,5,7,4,5,5,5,2,181,32,4,32,3,2,32,324,4,3]);
    expect result == 10;
}

method {:test} test_1()
{
    var result := skjkasdkd([1,0,1,8,2,4597,2,1,3,40,1,2,1,2,4,2,5,1]);
    expect result == 25;
}

method {:test} test_2()
{
    var result := skjkasdkd([1,3,1,32,5107,34,83278,109,163,23,2323,32,30,1,9,3]);
    expect result == 13;
}

method {:test} test_3()
{
    var result := skjkasdkd([0,724,32,71,99,32,6,0,5,91,83,0,5,6]);
    expect result == 11;
}

method {:test} test_4()
{
    var result := skjkasdkd([0,81,12,3,1,21]);
    expect result == 3;
}

method {:test} test_5()
{
    var result := skjkasdkd([0,8,1,2,1,7]);
    expect result == 7;
}

method {:test} test_6()
{
    var result := skjkasdkd([8191]);
    expect result == 19;
}

method {:test} test_7()
{
    var result := skjkasdkd([8191, 123456, 127, 7]);
    expect result == 19;
}

method {:test} test_8()
{
    var result := skjkasdkd([127, 97, 8192]);
    expect result == 10;
}