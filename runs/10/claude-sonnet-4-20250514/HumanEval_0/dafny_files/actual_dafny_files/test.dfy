method has_close_elements(numbers: seq<real>, threshold: real) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := has_close_elements([1.0, 2.0, 3.9, 4.0, 5.0, 2.2], 0.3);
    expect result == true;
}

method {:test} test_1()
{
    var result := has_close_elements([1.0, 2.0, 3.9, 4.0, 5.0, 2.2], 0.05);
    expect result == false;
}

method {:test} test_2()
{
    var result := has_close_elements([1.0, 2.0, 5.9, 4.0, 5.0], 0.95);
    expect result == true;
}

method {:test} test_3()
{
    var result := has_close_elements([1.0, 2.0, 5.9, 4.0, 5.0], 0.8);
    expect result == false;
}

method {:test} test_4()
{
    var result := has_close_elements([1.0, 2.0, 3.0, 4.0, 5.0, 2.0], 0.1);
    expect result == true;
}

method {:test} test_5()
{
    var result := has_close_elements([1.1, 2.2, 3.1, 4.1, 5.1], 1.0);
    expect result == true;
}

method {:test} test_6()
{
    var result := has_close_elements([1.1, 2.2, 3.1, 4.1, 5.1], 0.5);
    expect result == false;
}