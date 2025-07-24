method tri(n: int) returns (result: seq<int>)
  requires n >= 0
  ensures |result| == n + 1
{
    result := [0];
}

method {:test} test_0()
{
    var result := tri(3);
    expect result == [1, 3, 2, 8];
}

method {:test} test_1()
{
    var result := tri(4);
    expect result == [1, 3, 2, 8, 3];
}

method {:test} test_2()
{
    var result := tri(5);
    expect result == [1, 3, 2, 8, 3, 15];
}

method {:test} test_3()
{
    var result := tri(6);
    expect result == [1, 3, 2, 8, 3, 15, 4];
}

method {:test} test_4()
{
    var result := tri(7);
    expect result == [1, 3, 2, 8, 3, 15, 4, 24];
}

method {:test} test_5()
{
    var result := tri(8);
    expect result == [1, 3, 2, 8, 3, 15, 4, 24, 5];
}

method {:test} test_6()
{
    var result := tri(9);
    expect result == [1, 3, 2, 8, 3, 15, 4, 24, 5, 35];
}

method {:test} test_7()
{
    var result := tri(20);
    expect result == [1, 3, 2, 8, 3, 15, 4, 24, 5, 35, 6, 48, 7, 63, 8, 80, 9, 99, 10, 120, 11];
}

method {:test} test_8()
{
    var result := tri(0);
    expect result == [1];
}

method {:test} test_9()
{
    var result := tri(1);
    expect result == [1, 3];
}