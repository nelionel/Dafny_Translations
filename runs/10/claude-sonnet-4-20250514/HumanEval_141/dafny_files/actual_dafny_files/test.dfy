method file_name_check(file_name: string) returns (result: string)
    ensures result == "Yes" || result == "No"
{
    result := "No";
}

method {:test} test_0()
{
    var result := file_name_check("example.txt");
    expect result == "Yes";
}

method {:test} test_1()
{
    var result := file_name_check("1example.dll");
    expect result == "No";
}

method {:test} test_2()
{
    var result := file_name_check("s1sdf3.asd");
    expect result == "No";
}

method {:test} test_3()
{
    var result := file_name_check("K.dll");
    expect result == "Yes";
}

method {:test} test_4()
{
    var result := file_name_check("MY16FILE3.exe");
    expect result == "Yes";
}

method {:test} test_5()
{
    var result := file_name_check("His12FILE94.exe");
    expect result == "No";
}

method {:test} test_6()
{
    var result := file_name_check("_Y.txt");
    expect result == "No";
}

method {:test} test_7()
{
    var result := file_name_check("?aREYA.exe");
    expect result == "No";
}

method {:test} test_8()
{
    var result := file_name_check("/this_is_valid.dll");
    expect result == "No";
}

method {:test} test_9()
{
    var result := file_name_check("this_is_valid.wow");
    expect result == "No";
}

method {:test} test_10()
{
    var result := file_name_check("this_is_valid.txt");
    expect result == "Yes";
}

method {:test} test_11()
{
    var result := file_name_check("this_is_valid.txtexe");
    expect result == "No";
}

method {:test} test_12()
{
    var result := file_name_check("#this2_i4s_5valid.ten");
    expect result == "No";
}

method {:test} test_13()
{
    var result := file_name_check("@this1_is6_valid.exe");
    expect result == "No";
}

method {:test} test_14()
{
    var result := file_name_check("this_is_12valid.6exe4.txt");
    expect result == "No";
}

method {:test} test_15()
{
    var result := file_name_check("all.exe.txt");
    expect result == "No";
}

method {:test} test_16()
{
    var result := file_name_check("I563_No.exe");
    expect result == "Yes";
}

method {:test} test_17()
{
    var result := file_name_check("Is3youfault.txt");
    expect result == "Yes";
}

method {:test} test_18()
{
    var result := file_name_check("no_one#knows.dll");
    expect result == "Yes";
}

method {:test} test_19()
{
    var result := file_name_check("1I563_Yes3.exe");
    expect result == "No";
}

method {:test} test_20()
{
    var result := file_name_check("I563_Yes3.txtt");
    expect result == "No";
}

method {:test} test_21()
{
    var result := file_name_check("final..txt");
    expect result == "No";
}

method {:test} test_22()
{
    var result := file_name_check("final132");
    expect result == "No";
}

method {:test} test_23()
{
    var result := file_name_check("_f4indsartal132.");
    expect result == "No";
}

method {:test} test_24()
{
    var result := file_name_check(".txt");
    expect result == "No";
}

method {:test} test_25()
{
    var result := file_name_check("s.");
    expect result == "No";
}