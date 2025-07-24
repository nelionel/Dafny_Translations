method strange_sort_list(lst: seq<int>) returns (result: seq<int>)
{
    result := [];
}

method {:test} test_0()
{
    var result := strange_sort_list([1, 2, 3, 4]);
    expect result == [1, 4, 2, 3];
}

method {:test} test_1()
{
    var result := strange_sort_list([5, 6, 7, 8, 9]);
    expect result == [5, 9, 6, 8, 7];
}

method {:test} test_2()
{
    var result := strange_sort_list([1, 2, 3, 4, 5]);
    expect result == [1, 5, 2, 4, 3];
}

method {:test} test_3()
{
    var result := strange_sort_list([5, 6, 7, 8, 9, 1]);
    expect result == [1, 9, 5, 8, 6, 7];
}

method {:test} test_4()
{
    var result := strange_sort_list([5, 5, 5, 5]);
    expect result == [5, 5, 5, 5];
}

method {:test} test_5()
{
    var result := strange_sort_list([]);
    expect result == [];
}

method {:test} test_6()
{
    var result := strange_sort_list([1, 2, 3, 4, 5, 6, 7, 8]);
    expect result == [1, 8, 2, 7, 3, 6, 4, 5];
}

method {:test} test_7()
{
    var result := strange_sort_list([0, 2, 2, 2, 5, 5, -5, -5]);
    expect result == [-5, 5, -5, 5, 0, 2, 2, 2];
}

method {:test} test_8()
{
    var result := strange_sort_list([111111]);
    expect result == [111111];
}