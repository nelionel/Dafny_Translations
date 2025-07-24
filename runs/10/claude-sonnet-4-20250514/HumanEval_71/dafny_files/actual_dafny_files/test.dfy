method triangle_area(a: real, b: real, c: real) returns (result: real)
  requires a > 0.0 && b > 0.0 && c > 0.0
{
    result := 0.0;
}

method {:test} test_0()
{
    var result := triangle_area(3.0, 4.0, 5.0);
    expect result == 6.00;
}

method {:test} test_1()
{
    var result := triangle_area(1.0, 2.0, 10.0);
    expect result == -1.0;
}

method {:test} test_2()
{
    var result := triangle_area(4.0, 8.0, 5.0);
    expect result == 8.18;
}

method {:test} test_3()
{
    var result := triangle_area(2.0, 2.0, 2.0);
    expect result == 1.73;
}

method {:test} test_4()
{
    var result := triangle_area(1.0, 2.0, 3.0);
    expect result == -1.0;
}

method {:test} test_5()
{
    var result := triangle_area(10.0, 5.0, 7.0);
    expect result == 16.25;
}

method {:test} test_6()
{
    var result := triangle_area(2.0, 6.0, 3.0);
    expect result == -1.0;
}

method {:test} test_7()
{
    var result := triangle_area(1.0, 1.0, 1.0);
    expect result == 0.43;
}

method {:test} test_8()
{
    var result := triangle_area(2.0, 2.0, 10.0);
    expect result == -1.0;
}