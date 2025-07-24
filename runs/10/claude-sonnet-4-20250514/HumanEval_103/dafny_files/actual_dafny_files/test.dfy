method rounded_avg(n: int, m: int) returns (result: string)
  requires n > 0 && m > 0
{
    result := "";
}

method {:test} test_0()
{
    var result := rounded_avg(1, 5);
    expect result == "0b11";
}

method {:test} test_1()
{
    var result := rounded_avg(7, 13);
    expect result == "0b1010";
}

method {:test} test_2()
{
    var result := rounded_avg(964, 977);
    expect result == "0b1111001010";
}

method {:test} test_3()
{
    var result := rounded_avg(996, 997);
    expect result == "0b1111100100";
}

method {:test} test_4()
{
    var result := rounded_avg(560, 851);
    expect result == "0b1011000010";
}

method {:test} test_5()
{
    var result := rounded_avg(185, 546);
    expect result == "0b101101110";
}

method {:test} test_6()
{
    var result := rounded_avg(362, 496);
    expect result == "0b110101101";
}

method {:test} test_7()
{
    var result := rounded_avg(350, 902);
    expect result == "0b1001110010";
}

method {:test} test_8()
{
    var result := rounded_avg(197, 233);
    expect result == "0b11010111";
}

method {:test} test_9()
{
    var result := rounded_avg(7, 5);
    expect result == "-1";
}

method {:test} test_10()
{
    var result := rounded_avg(5, 1);
    expect result == "-1";
}

method {:test} test_11()
{
    var result := rounded_avg(5, 5);
    expect result == "0b101";
}