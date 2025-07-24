method make_a_pile(n: int) returns (pile: seq<int>)
{
    pile := [];
}

method {:test} test_0()
{
    var result := make_a_pile(3);
    expect result == [3, 5, 7];
}

method {:test} test_1()
{
    var result := make_a_pile(4);
    expect result == [4, 6, 8, 10];
}

method {:test} test_2()
{
    var result := make_a_pile(5);
    expect result == [5, 7, 9, 11, 13];
}

method {:test} test_3()
{
    var result := make_a_pile(6);
    expect result == [6, 8, 10, 12, 14, 16];
}

method {:test} test_4()
{
    var result := make_a_pile(8);
    expect result == [8, 10, 12, 14, 16, 18, 20, 22];
}

method {:test} test_5()
{
    expect true;
}