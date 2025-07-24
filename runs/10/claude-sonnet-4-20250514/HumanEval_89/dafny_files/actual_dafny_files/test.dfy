method encrypt(s: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := encrypt("hi");
    expect result == "lm";
}

method {:test} test_1()
{
    var result := encrypt("asdfghjkl");
    expect result == "ewhjklnop";
}

method {:test} test_2()
{
    var result := encrypt("gf");
    expect result == "kj";
}

method {:test} test_3()
{
    var result := encrypt("et");
    expect result == "ix";
}

method {:test} test_4()
{
    var result := encrypt("faewfawefaewg");
    expect result == "jeiajeaijeiak";
}

method {:test} test_5()
{
    var result := encrypt("hellomyfriend");
    expect result == "lippsqcjvmirh";
}

method {:test} test_6()
{
    var result := encrypt("dxzdlmnilfuhmilufhlihufnmlimnufhlimnufhfucufh");
    expect result == "hbdhpqrmpjylqmpyjlpmlyjrqpmqryjlpmqryjljygyjl";
}

method {:test} test_7()
{
    var result := encrypt("a");
    expect result == "e";
}