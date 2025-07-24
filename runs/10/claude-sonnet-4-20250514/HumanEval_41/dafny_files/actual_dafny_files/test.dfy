method car_race_collision(n: int) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := car_race_collision(2);
    expect result == 4;
}

method {:test} test_1()
{
    var result := car_race_collision(3);
    expect result == 9;
}

method {:test} test_2()
{
    var result := car_race_collision(4);
    expect result == 16;
}

method {:test} test_3()
{
    var result := car_race_collision(8);
    expect result == 64;
}

method {:test} test_4()
{
    var result := car_race_collision(10);
    expect result == 100;
}