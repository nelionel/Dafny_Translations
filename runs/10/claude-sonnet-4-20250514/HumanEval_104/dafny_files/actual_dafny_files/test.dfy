method unique_digits(x: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := unique_digits([15, 33, 1422, 1]);
    expect result == [1, 15, 33];
}

method {:test} test_1()
{
    var result := unique_digits([152, 323, 1422, 10]);
    expect result == [];
}

method {:test} test_2()
{
    var result := unique_digits([12345, 2033, 111, 151]);
    expect result == [111, 151];
}

method {:test} test_3()
{
    var result := unique_digits([135, 103, 31]);
    expect result == [31, 135];
}