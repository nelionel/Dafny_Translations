method get_row(lst: seq<seq<int>>, x: int) returns (coordinates: seq<(int, int)>)
{
    coordinates := [];
}

method {:test} test_0()
{
    var result := get_row([
        [1,2,3,4,5,6],
        [1,2,3,4,1,6],
        [1,2,3,4,5,1]
    ], 1);
    expect result == [(0, 0), (1, 4), (1, 0), (2, 5), (2, 0)];
}

method {:test} test_1()
{
    var result := get_row([
        [1,2,3,4,5,6],
        [1,2,3,4,5,6],
        [1,2,3,4,5,6],
        [1,2,3,4,5,6],
        [1,2,3,4,5,6],
        [1,2,3,4,5,6]
    ], 2);
    expect result == [(0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1)];
}

method {:test} test_2()
{
    var result := get_row([
        [1,2,3,4,5,6],
        [1,2,3,4,5,6],
        [1,1,3,4,5,6],
        [1,2,1,4,5,6],
        [1,2,3,1,5,6],
        [1,2,3,4,1,6],
        [1,2,3,4,5,1]
    ], 1);
    expect result == [(0, 0), (1, 0), (2, 1), (2, 0), (3, 2), (3, 0), (4, 3), (4, 0), (5, 4), (5, 0), (6, 5), (6, 0)];
}

method {:test} test_3()
{
    var result := get_row([], 1);
    expect result == [];
}

method {:test} test_4()
{
    var result := get_row([[1]], 2);
    expect result == [];
}

method {:test} test_5()
{
    var result := get_row([[], [1], [1, 2, 3]], 3);
    expect result == [(2, 2)];
}