method digits(n: int) returns (result: int)
  requires n > 0
  ensures result >= 0
{
  result := 0;
}

method {:test} test_0()
{
    var result := digits(5);
    expect result == 5;
}

method {:test} test_1()
{
    var result := digits(54);
    expect result == 5;
}

method {:test} test_2()
{
    var result := digits(120);
    expect result == 1;
}

method {:test} test_3()
{
    var result := digits(5014);
    expect result == 5;
}

method {:test} test_4()
{
    var result := digits(98765);
    expect result == 315;
}

method {:test} test_5()
{
    var result := digits(5576543);
    expect result == 2625;
}

method {:test} test_6()
{
    var result := digits(2468);
    expect result == 0;
}