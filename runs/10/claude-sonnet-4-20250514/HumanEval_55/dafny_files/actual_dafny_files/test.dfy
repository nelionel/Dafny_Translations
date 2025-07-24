method fib(n: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := fib(10);
    expect result == 55;
}

method {:test} test_1()
{
    var result := fib(1);
    expect result == 1;
}

method {:test} test_2()
{
    var result := fib(8);
    expect result == 21;
}

method {:test} test_3()
{
    var result := fib(11);
    expect result == 89;
}

method {:test} test_4()
{
    var result := fib(12);
    expect result == 144;
}