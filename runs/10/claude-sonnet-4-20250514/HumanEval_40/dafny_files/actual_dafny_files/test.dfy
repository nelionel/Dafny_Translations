method triples_sum_to_zero(l: seq<int>) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := triples_sum_to_zero([1, 3, 5, 0]);
    expect result == false;
}

method {:test} test_1()
{
    var result := triples_sum_to_zero([1, 3, 5, -1]);
    expect result == false;
}

method {:test} test_2()
{
    var result := triples_sum_to_zero([1, 3, -2, 1]);
    expect result == true;
}

method {:test} test_3()
{
    var result := triples_sum_to_zero([1, 2, 3, 7]);
    expect result == false;
}

method {:test} test_4()
{
    var result := triples_sum_to_zero([1, 2, 5, 7]);
    expect result == false;
}

method {:test} test_5()
{
    var result := triples_sum_to_zero([2, 4, -5, 3, 9, 7]);
    expect result == true;
}

method {:test} test_6()
{
    var result := triples_sum_to_zero([1]);
    expect result == false;
}

method {:test} test_7()
{
    var result := triples_sum_to_zero([1, 3, 5, -100]);
    expect result == false;
}

method {:test} test_8()
{
    var result := triples_sum_to_zero([100, 3, 5, -100]);
    expect result == false;
}