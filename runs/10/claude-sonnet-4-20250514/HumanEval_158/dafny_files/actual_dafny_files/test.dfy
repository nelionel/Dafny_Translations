method find_max(words: seq<string>) returns (result: string)
{
    result := "";
}

method {:test} test_0()
{
    var result := find_max(["name", "of", "string"]);
    expect result == "string";
}

method {:test} test_1()
{
    var result := find_max(["name", "enam", "game"]);
    expect result == "enam";
}

method {:test} test_2()
{
    var result := find_max(["aaaaaaa", "bb", "cc"]);
    expect result == "aaaaaaa";
}

method {:test} test_3()
{
    var result := find_max(["abc", "cba"]);
    expect result == "abc";
}

method {:test} test_4()
{
    var result := find_max(["play", "this", "game", "of", "footbott"]);
    expect result == "footbott";
}

method {:test} test_5()
{
    var result := find_max(["we", "are", "gonna", "rock"]);
    expect result == "gonna";
}

method {:test} test_6()
{
    var result := find_max(["we", "are", "a", "mad", "nation"]);
    expect result == "nation";
}

method {:test} test_7()
{
    var result := find_max(["this", "is", "a", "prrk"]);
    expect result == "this";
}

method {:test} test_8()
{
    var result := find_max(["b"]);
    expect result == "b";
}

method {:test} test_9()
{
    var result := find_max(["play", "play", "play"]);
    expect result == "play";
}