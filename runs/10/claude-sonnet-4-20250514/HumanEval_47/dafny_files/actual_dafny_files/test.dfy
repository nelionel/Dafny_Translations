method median(l: seq<real>) returns (result: real)
  requires |l| > 0
{
    result := 0.0;
}

method {:test} test_0()
{
    var result := median([3.0, 1.0, 2.0, 4.0, 5.0]);
    expect result == 3.0;
}

method {:test} test_1()
{
    var result := median([-10.0, 4.0, 6.0, 1000.0, 10.0, 20.0]);
    expect result == 8.0;
}

method {:test} test_2()
{
    var result := median([5.0]);
    expect result == 5.0;
}

method {:test} test_3()
{
    var result := median([6.0, 5.0]);
    expect result == 5.5;
}

method {:test} test_4()
{
    var result := median([8.0, 1.0, 3.0, 9.0, 9.0, 2.0, 7.0]);
    expect result == 7.0;
}