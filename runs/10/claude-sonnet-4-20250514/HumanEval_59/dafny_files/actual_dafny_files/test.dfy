method largest_prime_factor(n: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := largest_prime_factor(15);
    expect result == 5;
}

method {:test} test_1()
{
    var result := largest_prime_factor(27);
    expect result == 3;
}

method {:test} test_2()
{
    var result := largest_prime_factor(63);
    expect result == 7;
}

method {:test} test_3()
{
    var result := largest_prime_factor(330);
    expect result == 11;
}

method {:test} test_4()
{
    var result := largest_prime_factor(13195);
    expect result == 29;
}