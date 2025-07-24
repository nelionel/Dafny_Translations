method add_elements(arr: seq<int>, k: int) returns (result: int)
    requires 1 <= |arr| <= 100
    requires 1 <= k <= |arr|
{
    result := 0;
}

method {:test} test_0()
{
    var result := add_elements([1,-2,-3,41,57,76,87,88,99], 3);
    expect result == -4;
}

method {:test} test_1()
{
    var result := add_elements([111,121,3,4000,5,6], 2);
    expect result == 0;
}

method {:test} test_2()
{
    var result := add_elements([11,21,3,90,5,6,7,8,9], 4);
    expect result == 125;
}

method {:test} test_3()
{
    var result := add_elements([111,21,3,4000,5,6,7,8,9], 4);
    expect result == 24;
}

method {:test} test_4()
{
    var result := add_elements([1], 1);
    expect result == 1;
}