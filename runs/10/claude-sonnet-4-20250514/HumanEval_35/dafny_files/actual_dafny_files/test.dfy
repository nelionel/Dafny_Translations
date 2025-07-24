method max_element(l: seq<int>) returns (max_val: int)
{
    max_val := 0;
}

method {:test} test_0()
{
    var result := max_element([1, 2, 3]);
    expect result == 3;
}

method {:test} test_1()
{
    var result := max_element([5, 3, -5, 2, -3, 3, 9, 0, 124, 1, -10]);
    expect result == 124;
}