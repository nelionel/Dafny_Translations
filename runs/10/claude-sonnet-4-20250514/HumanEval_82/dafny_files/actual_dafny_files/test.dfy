method prime_length(s: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := prime_length("Hello");
    expect result == true;
}

method {:test} test_1()
{
    var result := prime_length("abcdcba");
    expect result == true;
}

method {:test} test_2()
{
    var result := prime_length("kittens");
    expect result == true;
}

method {:test} test_3()
{
    var result := prime_length("orange");
    expect result == false;
}

method {:test} test_4()
{
    var result := prime_length("wow");
    expect result == true;
}

method {:test} test_5()
{
    var result := prime_length("world");
    expect result == true;
}

method {:test} test_6()
{
    var result := prime_length("MadaM");
    expect result == true;
}

method {:test} test_7()
{
    var result := prime_length("Wow");
    expect result == true;
}

method {:test} test_8()
{
    var result := prime_length("");
    expect result == false;
}

method {:test} test_9()
{
    var result := prime_length("HI");
    expect result == true;
}

method {:test} test_10()
{
    var result := prime_length("go");
    expect result == true;
}

method {:test} test_11()
{
    var result := prime_length("gogo");
    expect result == false;
}

method {:test} test_12()
{
    var result := prime_length("aaaaaaaaaaaaaaa");
    expect result == false;
}

method {:test} test_13()
{
    var result := prime_length("Madam");
    expect result == true;
}

method {:test} test_14()
{
    var result := prime_length("M");
    expect result == false;
}

method {:test} test_15()
{
    var result := prime_length("0");
    expect result == false;
}