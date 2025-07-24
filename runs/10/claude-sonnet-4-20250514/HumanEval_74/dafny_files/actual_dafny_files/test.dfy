function TotalChars(lst: seq<string>): nat
{
    0
}

method total_match(lst1: seq<string>, lst2: seq<string>) returns (result: seq<string>)
{
    result := [];
}

method {:test} test_0()
{
    var result := total_match([], []);
    expect result == [];
}

method {:test} test_1()
{
    var result := total_match(["hi", "admin"], ["hi", "hi"]);
    expect result == ["hi", "hi"];
}

method {:test} test_2()
{
    var result := total_match(["hi", "admin"], ["hi", "hi", "admin", "project"]);
    expect result == ["hi", "admin"];
}

method {:test} test_3()
{
    var result := total_match(["4"], ["1", "2", "3", "4", "5"]);
    expect result == ["4"];
}

method {:test} test_4()
{
    var result := total_match(["hi", "admin"], ["hI", "Hi"]);
    expect result == ["hI", "Hi"];
}

method {:test} test_5()
{
    var result := total_match(["hi", "admin"], ["hI", "hi", "hi"]);
    expect result == ["hI", "hi", "hi"];
}

method {:test} test_6()
{
    var result := total_match(["hi", "admin"], ["hI", "hi", "hii"]);
    expect result == ["hi", "admin"];
}

method {:test} test_7()
{
    var result := total_match([], ["this"]);
    expect result == [];
}

method {:test} test_8()
{
    var result := total_match(["this"], []);
    expect result == [];
}