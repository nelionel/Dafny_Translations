method is_multiply_prime(a: int) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := is_multiply_prime(5);
    expect result == false;
}

method {:test} test_1()
{
    var result := is_multiply_prime(30);
    expect result == true;
}

method {:test} test_2()
{
    var result := is_multiply_prime(8);
    expect result == true;
}

method {:test} test_3()
{
    var result := is_multiply_prime(10);
    expect result == false;
}

method {:test} test_4()
{
    var result := is_multiply_prime(125);
    expect result == true;
}

method {:test} test_5()
{
    var result := is_multiply_prime(105);  // 3 * 5 * 7 = 105
    expect result == true;
}

method {:test} test_6()
{
    var result := is_multiply_prime(126);  // 3 * 6 * 7 = 126
    expect result == false;
}

method {:test} test_7()
{
    var result := is_multiply_prime(729);  // 9 * 9 * 9 = 729
    expect result == false;
}

method {:test} test_8()
{
    var result := is_multiply_prime(891);  // 11 * 9 * 9 = 891
    expect result == false;
}

method {:test} test_9()
{
    var result := is_multiply_prime(1001);  // 11 * 13 * 7 = 1001
    expect result == true;
}