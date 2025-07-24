method starts_one_ends(n: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := starts_one_ends(1);
    expect result == 1;
}

method {:test} test_1()
{
    var result := starts_one_ends(2);
    expect result == 18;
}

method {:test} test_2()
{
    var result := starts_one_ends(3);
    expect result == 180;
}

method {:test} test_3()
{
    var result := starts_one_ends(4);
    expect result == 1800;
}

method {:test} test_4()
{
    var result := starts_one_ends(5);
    expect result == 18000;
}