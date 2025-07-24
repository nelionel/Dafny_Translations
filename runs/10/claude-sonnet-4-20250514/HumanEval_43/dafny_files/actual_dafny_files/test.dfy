predicate Contains(s: seq<int>, x: int)
{
    false
}

method pairs_sum_to_zero(l: seq<int>) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := pairs_sum_to_zero([1, 3, 5, 0]);
    expect result == false;
}

method {:test} test_1()
{
    var result := pairs_sum_to_zero([1, 3, -2, 1]);
    expect result == false;
}

method {:test} test_2()
{
    var result := pairs_sum_to_zero([1, 2, 3, 7]);
    expect result == false;
}

method {:test} test_3()
{
    var result := pairs_sum_to_zero([2, 4, -5, 3, 5, 7]);
    expect result == true;
}

method {:test} test_4()
{
    var result := pairs_sum_to_zero([1]);
    expect result == false;
}

method {:test} test_5()
{
    var result := pairs_sum_to_zero([-3, 9, -1, 3, 2, 30]);
    expect result == true;
}

method {:test} test_6()
{
    var result := pairs_sum_to_zero([-3, 9, -1, 3, 2, 31]);
    expect result == true;
}

method {:test} test_7()
{
    var result := pairs_sum_to_zero([-3, 9, -1, 4, 2, 30]);
    expect result == false;
}

method {:test} test_8()
{
    var result := pairs_sum_to_zero([-3, 9, -1, 4, 2, 31]);
    expect result == false;
}