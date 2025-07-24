method generate_integers(a: int, b: int) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := generate_integers(2, 10);
    expect result == [2, 4, 6, 8];
}

method {:test} test_1()
{
    var result := generate_integers(10, 2);
    expect result == [2, 4, 6, 8];
}

method {:test} test_2()
{
    var result := generate_integers(132, 2);
    expect result == [2, 4, 6, 8];
}

method {:test} test_3()
{
    var result := generate_integers(17, 89);
    expect result == [];
}

method {:test} test_4()
{
    // This corresponds to "assert True" - always passes
    expect true;
}