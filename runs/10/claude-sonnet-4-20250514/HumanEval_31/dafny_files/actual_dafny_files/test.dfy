method is_prime(n: int) returns (result: bool)
{
    return false;
}

method {:test} test_0()
{
    var result := is_prime(6);
    expect result == false;
}

method {:test} test_1()
{
    var result := is_prime(101);
    expect result == true;
}

method {:test} test_2()
{
    var result := is_prime(11);
    expect result == true;
}

method {:test} test_3()
{
    var result := is_prime(13441);
    expect result == true;
}

method {:test} test_4()
{
    var result := is_prime(61);
    expect result == true;
}

method {:test} test_5()
{
    var result := is_prime(4);
    expect result == false;
}

method {:test} test_6()
{
    var result := is_prime(1);
    expect result == false;
}

method {:test} test_7()
{
    var result := is_prime(5);
    expect result == true;
}

method {:test} test_8()
{
    var result := is_prime(11);
    expect result == true;
}

method {:test} test_9()
{
    var result := is_prime(17);
    expect result == true;
}

method {:test} test_10()
{
    var result := is_prime(85);
    expect result == false;
}

method {:test} test_11()
{
    var result := is_prime(77);
    expect result == false;
}

method {:test} test_12()
{
    var result := is_prime(255379);
    expect result == false;
}