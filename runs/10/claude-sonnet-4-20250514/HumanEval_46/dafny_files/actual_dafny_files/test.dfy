method fib4(n: int) returns (result: int)
  requires n >= 0
{
  return 0;
}

method {:test} test_0()
{
    var result := fib4(5);
    expect result == 4;
}

method {:test} test_1()
{
    var result := fib4(8);
    expect result == 28;
}

method {:test} test_2()
{
    var result := fib4(10);
    expect result == 104;
}

method {:test} test_3()
{
    var result := fib4(12);
    expect result == 386;
}