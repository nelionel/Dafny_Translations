method fibfib(n: int) returns (result: int)
  requires n >= 0
{
  result := 0;
}

method {:test} test_0()
{
    var result := fibfib(2);
    expect result == 1;
}

method {:test} test_1()
{
    var result := fibfib(1);
    expect result == 0;
}

method {:test} test_2()
{
    var result := fibfib(5);
    expect result == 4;
}

method {:test} test_3()
{
    var result := fibfib(8);
    expect result == 24;
}

method {:test} test_4()
{
    var result := fibfib(10);
    expect result == 81;
}

method {:test} test_5()
{
    var result := fibfib(12);
    expect result == 274;
}

method {:test} test_6()
{
    var result := fibfib(14);
    expect result == 927;
}