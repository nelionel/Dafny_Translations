method make_palindrome(s: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := make_palindrome("");
    expect result == "";
}

method {:test} test_1()
{
    var result := make_palindrome("x");
    expect result == "x";
}

method {:test} test_2()
{
    var result := make_palindrome("xyz");
    expect result == "xyzyx";
}

method {:test} test_3()
{
    var result := make_palindrome("xyx");
    expect result == "xyx";
}

method {:test} test_4()
{
    var result := make_palindrome("jerry");
    expect result == "jerryrrej";
}