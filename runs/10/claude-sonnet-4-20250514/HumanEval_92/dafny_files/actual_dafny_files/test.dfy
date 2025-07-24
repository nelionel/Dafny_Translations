method any_int(x: real, y: real, z: real) returns (result: bool)
{
    return false;
}

method {:test} test_0()
{
    var result := any_int(2.0, 3.0, 1.0);
    expect result == true;
}

method {:test} test_1()
{
    var result := any_int(2.5, 2.0, 3.0);
    expect result == false;
}

method {:test} test_2()
{
    var result := any_int(1.5, 5.0, 3.5);
    expect result == false;
}

method {:test} test_3()
{
    var result := any_int(2.0, 6.0, 2.0);
    expect result == false;
}

method {:test} test_4()
{
    var result := any_int(4.0, 2.0, 2.0);
    expect result == true;
}

method {:test} test_5()
{
    var result := any_int(2.2, 2.2, 2.2);
    expect result == false;
}

method {:test} test_6()
{
    var result := any_int(-4.0, 6.0, 2.0);
    expect result == true;
}

method {:test} test_7()
{
    var result := any_int(2.0, 1.0, 1.0);
    expect result == true;
}

method {:test} test_8()
{
    var result := any_int(3.0, 4.0, 7.0);
    expect result == true;
}

method {:test} test_9()
{
    var result := any_int(3.0, 4.0, 7.0);
    expect result == false;
}