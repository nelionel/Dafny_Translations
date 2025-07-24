method remove_vowels(text: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := remove_vowels("");
    expect result == "";
}

method {:test} test_1()
{
    var result := remove_vowels("abcdef\nghijklm");
    expect result == "bcdf\nghjklm";
}

method {:test} test_2()
{
    var result := remove_vowels("fedcba");
    expect result == "fdcb";
}

method {:test} test_3()
{
    var result := remove_vowels("eeeee");
    expect result == "";
}

method {:test} test_4()
{
    var result := remove_vowels("acBAA");
    expect result == "cB";
}

method {:test} test_5()
{
    var result := remove_vowels("EcBOO");
    expect result == "cB";
}

method {:test} test_6()
{
    var result := remove_vowels("ybcd");
    expect result == "ybcd";
}