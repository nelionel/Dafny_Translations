method move_one_ball(arr: seq<int>) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := move_one_ball([3, 4, 5, 1, 2]);
    expect result == true;
}

method {:test} test_1()
{
    var result := move_one_ball([3, 5, 10, 1, 2]);
    expect result == true;
}

method {:test} test_2()
{
    var result := move_one_ball([4, 3, 1, 2]);
    expect result == false;
}

method {:test} test_3()
{
    var result := move_one_ball([3, 5, 4, 1, 2]);
    expect result == false;
}

method {:test} test_4()
{
    var result := move_one_ball([]);
    expect result == true;
}