method is_happy(s: string) returns (result: bool)
{
    return false;
}

method {:test} test_0()
{
    var result := is_happy("a");
    expect result == false;
}

method {:test} test_1()
{
    var result := is_happy("aa");
    expect result == false;
}

method {:test} test_2()
{
    var result := is_happy("abcd");
    expect result == true;
}

method {:test} test_3()
{
    var result := is_happy("aabb");
    expect result == false;
}

method {:test} test_4()
{
    var result := is_happy("adb");
    expect result == true;
}

method {:test} test_5()
{
    var result := is_happy("xyy");
    expect result == false;
}

method {:test} test_6()
{
    var result := is_happy("iopaxpoi");
    expect result == true;
}

method {:test} test_7()
{
    var result := is_happy("iopaxioi");
    expect result == false;
}