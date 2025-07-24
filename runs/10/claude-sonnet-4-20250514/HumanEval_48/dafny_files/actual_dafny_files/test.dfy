method is_palindrome(text: string) returns (result: bool)
{
    result := false;
}

method {:test} test_0()
{
    var result := is_palindrome("");
    expect result == true;
}

method {:test} test_1()
{
    var result := is_palindrome("aba");
    expect result == true;
}

method {:test} test_2()
{
    var result := is_palindrome("aaaaa");
    expect result == true;
}

method {:test} test_3()
{
    var result := is_palindrome("zbcd");
    expect result == false;
}

method {:test} test_4()
{
    var result := is_palindrome("xywyx");
    expect result == true;
}

method {:test} test_5()
{
    var result := is_palindrome("xywyz");
    expect result == false;
}

method {:test} test_6()
{
    var result := is_palindrome("xywzx");
    expect result == false;
}