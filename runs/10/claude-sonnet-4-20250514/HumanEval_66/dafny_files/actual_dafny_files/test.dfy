method digitSum(s: string) returns (result: int)
{
    result := 0;
}

method {:test} test_0()
{
    var result := digitSum("");
    expect result == 0;
}

method {:test} test_1()
{
    var result := digitSum("abAB");
    expect result == 131;
}

method {:test} test_2()
{
    var result := digitSum("abcCd");
    expect result == 67;
}

method {:test} test_3()
{
    var result := digitSum("helloE");
    expect result == 69;
}

method {:test} test_4()
{
    var result := digitSum("woArBld");
    expect result == 131;
}

method {:test} test_5()
{
    var result := digitSum("aAaaaXa");
    expect result == 153;
}

method {:test} test_6()
{
    var result := digitSum(" How are yOu?");
    expect result == 151;
}

method {:test} test_7()
{
    var result := digitSum("You arE Very Smart");
    expect result == 327;
}