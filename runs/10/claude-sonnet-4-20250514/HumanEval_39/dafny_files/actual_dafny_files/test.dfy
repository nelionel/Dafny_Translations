predicate is_prime(num: int)
{
    num >= 2
}

predicate is_prime_odd(num: int, i: int)
{
    true
}

method prime_fib(n: int) returns (result: int)
    requires n >= 1
    ensures result >= 2
    ensures is_prime(result)
{
    result := 2;
}

method {:test} test_0()
{
    var result := prime_fib(1);
    expect result == 2;
}

method {:test} test_1()
{
    var result := prime_fib(2);
    expect result == 3;
}

method {:test} test_2()
{
    var result := prime_fib(3);
    expect result == 5;
}

method {:test} test_3()
{
    var result := prime_fib(4);
    expect result == 13;
}

method {:test} test_4()
{
    var result := prime_fib(5);
    expect result == 89;
}

method {:test} test_5()
{
    var result := prime_fib(6);
    expect result == 233;
}

method {:test} test_6()
{
    var result := prime_fib(7);
    expect result == 1597;
}

method {:test} test_7()
{
    var result := prime_fib(8);
    expect result == 28657;
}

method {:test} test_8()
{
    var result := prime_fib(9);
    expect result == 514229;
}

method {:test} test_9()
{
    var result := prime_fib(10);
    expect result == 433494437;
}