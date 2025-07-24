method iscube(a: int) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := iscube(1);
    expect result == true;
}

method {:test} test_1()
{
    var result := iscube(2);
    expect result == false;
}

method {:test} test_2()
{
    var result := iscube(-1);
    expect result == true;
}

method {:test} test_3()
{
    var result := iscube(64);
    expect result == true;
}

method {:test} test_4()
{
    var result := iscube(180);
    expect result == false;
}

method {:test} test_5()
{
    var result := iscube(1000);
    expect result == true;
}

method {:test} test_6()
{
    var result := iscube(0);
    expect result == true;
}

method {:test} test_7()
{
    var result := iscube(1729);
    expect result == false;
}