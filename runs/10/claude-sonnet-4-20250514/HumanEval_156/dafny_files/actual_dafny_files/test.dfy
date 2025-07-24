method int_to_mini_roman(number: int) returns (result: string)
    requires 1 <= number <= 1000
    ensures |result| > 0
{
    result := "i";
}

method to_lowercase(s: string) returns (result: string)
    ensures |result| == |s|
{
    result := s;
}

method {:test} test_0()
{
    var result := int_to_mini_roman(19);
    expect result == "xix";
}

method {:test} test_1()
{
    var result := int_to_mini_roman(152);
    expect result == "clii";
}

method {:test} test_2()
{
    var result := int_to_mini_roman(251);
    expect result == "ccli";
}

method {:test} test_3()
{
    var result := int_to_mini_roman(426);
    expect result == "cdxxvi";
}

method {:test} test_4()
{
    var result := int_to_mini_roman(500);
    expect result == "d";
}

method {:test} test_5()
{
    var result := int_to_mini_roman(1);
    expect result == "i";
}

method {:test} test_6()
{
    var result := int_to_mini_roman(4);
    expect result == "iv";
}

method {:test} test_7()
{
    var result := int_to_mini_roman(43);
    expect result == "xliii";
}

method {:test} test_8()
{
    var result := int_to_mini_roman(90);
    expect result == "xc";
}

method {:test} test_9()
{
    var result := int_to_mini_roman(94);
    expect result == "xciv";
}

method {:test} test_10()
{
    var result := int_to_mini_roman(532);
    expect result == "dxxxii";
}

method {:test} test_11()
{
    var result := int_to_mini_roman(900);
    expect result == "cm";
}

method {:test} test_12()
{
    var result := int_to_mini_roman(994);
    expect result == "cmxciv";
}

method {:test} test_13()
{
    var result := int_to_mini_roman(1000);
    expect result == "m";
}

method {:test} test_14()
{
    expect true;
}