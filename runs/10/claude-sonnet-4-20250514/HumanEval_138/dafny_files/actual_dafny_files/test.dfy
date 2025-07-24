method is_equal_to_sum_even(n: int) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := is_equal_to_sum_even(4);
    expect result == false;
}

method {:test} test_1()
{
    var result := is_equal_to_sum_even(6);
    expect result == false;
}

method {:test} test_2()
{
    var result := is_equal_to_sum_even(8);
    expect result == true;
}

method {:test} test_3()
{
    var result := is_equal_to_sum_even(10);
    expect result == true;
}

method {:test} test_4()
{
    var result := is_equal_to_sum_even(11);
    expect result == false;
}

method {:test} test_5()
{
    var result := is_equal_to_sum_even(12);
    expect result == true;
}

method {:test} test_6()
{
    var result := is_equal_to_sum_even(13);
    expect result == false;
}

method {:test} test_7()
{
    var result := is_equal_to_sum_even(16);
    expect result == true;
}