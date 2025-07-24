method fizz_buzz(n: int) returns (count: int)
{
    count := 0;
}

method {:test} test_0()
{
    var result := fizz_buzz(50);
    expect result == 0;
}

method {:test} test_1()
{
    var result := fizz_buzz(78);
    expect result == 2;
}

method {:test} test_2()
{
    var result := fizz_buzz(79);
    expect result == 3;
}

method {:test} test_3()
{
    var result := fizz_buzz(100);
    expect result == 3;
}

method {:test} test_4()
{
    var result := fizz_buzz(200);
    expect result == 6;
}

method {:test} test_5()
{
    var result := fizz_buzz(4000);
    expect result == 192;
}

method {:test} test_6()
{
    var result := fizz_buzz(10000);
    expect result == 639;
}

method {:test} test_7()
{
    var result := fizz_buzz(100000);
    expect result == 8026;
}