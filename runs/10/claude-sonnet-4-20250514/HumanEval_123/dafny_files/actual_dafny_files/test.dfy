method get_odd_collatz(n: int) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := get_odd_collatz(14);
    expect result == [1, 5, 7, 11, 13, 17];
}

method {:test} test_1()
{
    var result := get_odd_collatz(5);
    expect result == [1, 5];
}

method {:test} test_2()
{
    var result := get_odd_collatz(12);
    expect result == [1, 3, 5];
}

method {:test} test_3()
{
    var result := get_odd_collatz(1);
    expect result == [1];
}