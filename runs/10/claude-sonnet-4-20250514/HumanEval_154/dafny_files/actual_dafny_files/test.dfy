method cycpattern_check(a: string, b: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := cycpattern_check("xyzw","xyw");
    expect result == false;
}

method {:test} test_1()
{
    var result := cycpattern_check("yello","ell");
    expect result == true;
}

method {:test} test_2()
{
    var result := cycpattern_check("whattup","ptut");
    expect result == false;
}

method {:test} test_3()
{
    var result := cycpattern_check("efef","fee");
    expect result == true;
}

method {:test} test_4()
{
    var result := cycpattern_check("abab","aabb");
    expect result == false;
}

method {:test} test_5()
{
    var result := cycpattern_check("winemtt","tinem");
    expect result == true;
}