method flip_case(s: string) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := flip_case("");
    expect result == "";
}

method {:test} test_1()
{
    var result := flip_case("Hello!");
    expect result == "hELLO!";
}

method {:test} test_2()
{
    var result := flip_case("These violent delights have violent ends");
    expect result == "tHESE VIOLENT DELIGHTS HAVE VIOLENT ENDS";
}