method parse_music(music_string: string) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := parse_music("");
    expect result == [];
}

method {:test} test_1()
{
    var result := parse_music("o o o o");
    expect result == [4, 4, 4, 4];
}

method {:test} test_2()
{
    var result := parse_music(".| .| .| .|");
    expect result == [1, 1, 1, 1];
}

method {:test} test_3()
{
    var result := parse_music("o| o| .| .| o o o o");
    expect result == [2, 2, 1, 1, 4, 4, 4, 4];
}

method {:test} test_4()
{
    var result := parse_music("o| .| o| .| o o| o o|");
    expect result == [2, 1, 2, 1, 4, 2, 4, 2];
}