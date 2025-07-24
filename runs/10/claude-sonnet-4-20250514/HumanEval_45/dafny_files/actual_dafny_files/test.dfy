method triangle_area(a: real, h: real) returns (area: real)
{
    area := 0.0;
}

method {:test} test_0()
{
    var result := triangle_area(5.0, 3.0);
    expect result == 7.5;
}

method {:test} test_1()
{
    var result := triangle_area(2.0, 2.0);
    expect result == 2.0;
}

method {:test} test_2()
{
    var result := triangle_area(10.0, 8.0);
    expect result == 40.0;
}