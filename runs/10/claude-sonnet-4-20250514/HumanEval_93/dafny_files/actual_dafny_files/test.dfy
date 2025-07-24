method encode(message: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := encode("TEST");
    expect result == "tgst";
}

method {:test} test_1()
{
    var result := encode("Mudasir");
    expect result == "mWDCSKR";
}

method {:test} test_2()
{
    var result := encode("YES");
    expect result == "ygs";
}

method {:test} test_3()
{
    var result := encode("This is a message");
    expect result == "tHKS KS C MGSSCGG";
}

method {:test} test_4()
{
    var result := encode("I DoNt KnOw WhAt tO WrItE");
    expect result == "k dQnT kNqW wHcT Tq wRkTg";
}