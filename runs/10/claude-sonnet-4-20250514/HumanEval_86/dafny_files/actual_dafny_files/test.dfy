method anti_shuffle(s: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := anti_shuffle("Hi");
    expect result == "Hi";
}

method {:test} test_1()
{
    var result := anti_shuffle("hello");
    expect result == "ehllo";
}

method {:test} test_2()
{
    var result := anti_shuffle("number");
    expect result == "bemnru";
}

method {:test} test_3()
{
    var result := anti_shuffle("abcd");
    expect result == "abcd";
}

method {:test} test_4()
{
    var result := anti_shuffle("Hello World!!!");
    expect result == "Hello !!!Wdlor";
}

method {:test} test_5()
{
    var result := anti_shuffle("");
    expect result == "";
}

method {:test} test_6()
{
    var result := anti_shuffle("Hi. My name is Mister Robot. How are you?");
    expect result == ".Hi My aemn is Meirst .Rboot How aer ?ouy";
}