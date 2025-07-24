method fix_spaces(text: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := fix_spaces("Example");
    expect result == "Example";
}

method {:test} test_1()
{
    var result := fix_spaces("Mudasir Hanif ");
    expect result == "Mudasir_Hanif_";
}

method {:test} test_2()
{
    var result := fix_spaces("Yellow Yellow  Dirty  Fellow");
    expect result == "Yellow_Yellow__Dirty__Fellow";
}

method {:test} test_3()
{
    var result := fix_spaces("Exa   mple");
    expect result == "Exa-mple";
}

method {:test} test_4()
{
    var result := fix_spaces("   Exa 1 2 2 mple");
    expect result == "-Exa_1_2_2_mple";
}