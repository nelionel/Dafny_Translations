method right_angle_triangle(a: real, b: real, c: real) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := right_angle_triangle(3.0, 4.0, 5.0);
    expect result == true;
}

method {:test} test_1()
{
    var result := right_angle_triangle(1.0, 2.0, 3.0);
    expect result == false;
}

method {:test} test_2()
{
    var result := right_angle_triangle(10.0, 6.0, 8.0);
    expect result == true;
}

method {:test} test_3()
{
    var result := right_angle_triangle(2.0, 2.0, 2.0);
    expect result == false;
}

method {:test} test_4()
{
    var result := right_angle_triangle(7.0, 24.0, 25.0);
    expect result == true;
}

method {:test} test_5()
{
    var result := right_angle_triangle(10.0, 5.0, 7.0);
    expect result == false;
}

method {:test} test_6()
{
    var result := right_angle_triangle(5.0, 12.0, 13.0);
    expect result == true;
}

method {:test} test_7()
{
    var result := right_angle_triangle(15.0, 8.0, 17.0);
    expect result == true;
}

method {:test} test_8()
{
    var result := right_angle_triangle(48.0, 55.0, 73.0);
    expect result == true;
}

method {:test} test_9()
{
    var result := right_angle_triangle(1.0, 1.0, 1.0);
    expect result == false;
}

method {:test} test_10()
{
    var result := right_angle_triangle(2.0, 2.0, 10.0);
    expect result == false;
}