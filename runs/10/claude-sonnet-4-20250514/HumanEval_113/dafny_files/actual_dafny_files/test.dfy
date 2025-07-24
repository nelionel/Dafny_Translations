method odd_count(lst: seq<string>) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := odd_count(["1234567"]);
    expect result == ["the number of odd elements 4n the str4ng 4 of the 4nput."];
}

method {:test} test_1()
{
    var result := odd_count(["3", "11111111"]);
    expect result == ["the number of odd elements 1n the str1ng 1 of the 1nput.", "the number of odd elements 8n the str8ng 8 of the 8nput."];
}

method {:test} test_2()
{
    var result := odd_count(["271", "137", "314"]);
    expect result == [
        "the number of odd elements 2n the str2ng 2 of the 2nput.",
        "the number of odd elements 3n the str3ng 3 of the 3nput.",
        "the number of odd elements 2n the str2ng 2 of the 2nput."
    ];
}

method {:test} test_3()
{
    // This corresponds to "assert True" - a trivial test that always passes
    expect true;
}