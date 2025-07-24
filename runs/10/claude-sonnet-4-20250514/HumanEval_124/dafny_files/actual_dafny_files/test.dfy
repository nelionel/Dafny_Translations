method valid_date(date: string) returns (result: bool)
{
    return false;
}

method {:test} test_0()
{
    var result := valid_date("03-11-2000");
    expect result == true;
}

method {:test} test_1()  
{
    var result := valid_date("15-01-2012");
    expect result == false;
}

method {:test} test_2()
{
    var result := valid_date("04-0-2040");
    expect result == false;
}

method {:test} test_3()
{
    var result := valid_date("06-04-2020");
    expect result == true;
}

method {:test} test_4()
{
    var result := valid_date("01-01-2007");
    expect result == true;
}

method {:test} test_5()
{
    var result := valid_date("03-32-2011");
    expect result == false;
}

method {:test} test_6()
{
    var result := valid_date("");
    expect result == false;
}

method {:test} test_7()
{
    var result := valid_date("04-31-3000");
    expect result == false;
}

method {:test} test_8()
{
    var result := valid_date("06-06-2005");
    expect result == true;
}

method {:test} test_9()
{
    var result := valid_date("21-31-2000");
    expect result == false;
}

method {:test} test_10()
{
    var result := valid_date("04-12-2003");
    expect result == true;
}

method {:test} test_11()
{
    var result := valid_date("04122003");
    expect result == false;
}

method {:test} test_12()
{
    var result := valid_date("20030412");
    expect result == false;
}

method {:test} test_13()
{
    var result := valid_date("2003-04");
    expect result == false;
}

method {:test} test_14()
{
    var result := valid_date("2003-04-12");
    expect result == false;
}

method {:test} test_15()
{
    var result := valid_date("04-2003");
    expect result == false;
}