method remove_duplicates(numbers: seq<int>) returns (result: seq<int>)
{
    result := [];
}

function count_occurrences(s: seq<int>, target: int): int
{
    0
}

method {:test} test_0()
{
    var result := remove_duplicates([]);
    expect result == [];
}

method {:test} test_1()
{
    var result := remove_duplicates([1, 2, 3, 4]);
    expect result == [1, 2, 3, 4];
}

method {:test} test_2()
{
    var result := remove_duplicates([1, 2, 3, 2, 4, 3, 5]);
    expect result == [1, 4, 5];
}